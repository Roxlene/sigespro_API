<?php

namespace App\Http\Controllers\Auth;

use GuzzleHttp\Client;
use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\RegisterEstudiante;
use App\Http\Requests\Auth\RegisterRequest;
use App\Models\Administracion\Direccion;
use App\Models\Administracion\Estatus;
use App\Models\Administracion\Tipo_usuario;
use App\Models\Datos;
use App\Models\Entidades\Comunidad;
use App\Models\Persona;
use App\Models\proyectos\notificaciones;
use App\Models\Seguridad\Auditoria;
use App\Models\Seguridad\Configuraciones;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class AutenticationsController extends Controller
{


    protected $client;
    protected $baseUrl = 'https://rest.clicksend.com/v3/';


    public function __construct()
    {
        $this->client = new Client([
            'base_uri' => $this->baseUrl,
            'headers' => [
                'Authorization' => 'Basic ' . base64_encode(config('services.clicksend.username') . ':' . config('services.clicksend.password')),
                'Content-Type' => 'application/json',
            ],
            'verify' => false, // Ruta al archivo cacert.pem
        ]);
    }

    public function register_comunidad(RegisterRequest $request)
    {

        try {

            //Validacion de representante con historia en la universidad
            $persona = Persona::whereCedula($request->cedula)->first();
            $tipo_usuario = Tipo_usuario::whereDescripcion('COMUNIDAD')->first();
            $estatus = Estatus::whereDescripcion('Activo')->first();
            $password = Str::random(10);
            mt_srand(time());
            $numero_aleatorio_message = mt_rand(1, 10000);

            if (empty($persona)) {
                $persona = Persona::create([
                    "cedula" => $request->prefijo_cedula . $request->cedula,
                    "nombres" => $request->nombres,
                    "apellidos" => $request->apellidos,
                    "fullname" => $request->nombres . ' ' . $request->apellidos,
                ]);
            }

            $direccion = Direccion::create([
                "id_estado" => $request->estado,
                "id_municipio" => $request->municipio,
                "id_parroquia" => $request->parroquia,
                "detalles" => $request->detalles,
            ]);

            $comunidad = Comunidad::create([
                "rif" => $request->rif,
                "nombre" => $request->nombre_empresa,
                "telefono" => $request->telefono_empresa,
                "id_direccion" => $direccion->id,

            ]);


            $user =  User::create([
                "id_persona" => $persona->id,
                "id_tipo_usuario" => $tipo_usuario->id,
                "email" => $request->email,
                "password" => Hash::make($password),
                "id_comunidad" => $comunidad->id,
                "id_estatus" => $estatus->id,
            ])->assignRole('COMUNIDAD');

            Auditoria::creacion_terceros(
                'La comunidad: ' . $comunidad->nombre . ' se acaba de registrar',
                'INSERT seguridad.usuarios',
                $user->id
            );
            notificaciones::create_notificacion_terceros('¡🎉Bienvenido al sistema!🎉', $user->id);
            event(new Registered($user));

            // Envio de correo
            $user->RegisterUser($password);

            //Envio de mensaje

            if (Configuraciones::whereDescripcion('MensajeriaSMS')->whereStatus(true)->first()) {
                $response = $this->client->post('sms/send', [
                    'json' => [
                        'messages' => [
                            [
                                'to' => $request->telefono_empresa,
                                'source' => "Mensaje de autenticación",
                                'body' => $numero_aleatorio_message . ' es su código de verificación para ' . config('app.name'),
                            ],
                        ],
                    ],
                ]);
            }

            Auth::login($user);

            $resultado = [
                'usuario'  => $user,
                'comunidad'  => $comunidad,
                'direccion_comunidad'  => $direccion,
                'codigo_sms' => $numero_aleatorio_message,
                'password' => $password
            ];

            return $this->success($resultado, 200, 'Registro exitoso');
        } catch (\Throwable $th) {
            DB::rollBack();
            Log::error($th, 400);
            return $this->error('Se ha presentado algun error al momento de registrar su cuenta. Por favor contacte al equipo de soporte para más información.', 400);
        }
    }

    public function register_estudiante(RegisterEstudiante $request)
    {

        mt_srand(time());
        $numero_aleatorio_message = mt_rand(1, 10000);
        $persona = Persona::whereCedula($request->cedula)->first();
        $tipo_usuario = Tipo_usuario::whereDescripcion('ESTUDIANTE')->first();
        $estatus = Estatus::whereDescripcion('Activo')->first();

        //Verificando si ya existe una persona con un usuario de estudiante registrado
        if (isset($persona) && User::whereId_persona($persona->id)->whereId_tipo_usuario($tipo_usuario->id)->first()) {
            return $this->message('El estudiante ya se encuentra registrado', 200);
        }

        try {
            $direccion = Direccion::create([
                'id_estado' => $request->estado,
                'id_municipio' => $request->municipio,
                'id_parroquia' => $request->parroquia,
                "detalles" => $request->detalles,

            ]);

            //Verificando si la persona ya ha sido registrada anteriormente
            if (isset($persona)) {
                $persona->update([
                    "nombres" => $request->nombres,
                    "apellidos" => $request->apellidos,
                    "fullname" => $request->nombres . ' ' . $request->apellidos,
                    "telefono" => $request->telefono,
                    "id_direccion" => $direccion->id,
                ]);
            } else {
                $persona = Persona::create([
                    "cedula" => $request->cedula,
                    "nombres" => $request->nombres,
                    "apellidos" => $request->apellidos,
                    "fullname" => $request->nombres . ' ' . $request->apellidos,
                    "telefono" => $request->telefono,
                    "id_direccion" => $direccion->id,
                ]);
            }

            $password = Str::random(10);

            $user =  User::create([
                "id_persona" => $persona->id,
                "email" => $request->email,
                "id_tipo_usuario" => $tipo_usuario->id,
                "password" => Hash::make($password),
                "id_estatus" => $estatus->id,
            ])->assignRole('ESTUDIANTE');

            $datos = Datos::create([
                'id_usuario' => $user->id,
                'cod_carrera' => $request->carrera,
                'seccion' => $request->seccion,
                'trayecto' => $request->trayecto,
                'estatus_id' => $estatus->id
            ]);

            Auditoria::creacion_terceros('El estudiante: ' . $persona->fullname . ' se acaba de registrar', 'INSERT seguridad.usuarios', $user->id);
            notificaciones::create_notificacion_terceros('¡🎉Bienvenido al sistema!🎉', $user->id);


            event(new Registered($user));

            // Envio de correo
            $user->RegisterUser($password);

            if (Configuraciones::whereDescripcion('MensajeriaSMS')->whereStatus(true)->first()) {

                //Envio de mensaje
                $response = $this->client->post('sms/send', [
                    'json' => [
                        'messages' => [
                            [
                                'to' => $request->telefono,
                                'source' => "Mensaje de autenticación",
                                'body' => $numero_aleatorio_message . ' es su código de verificación para ' . config('app.name'),
                            ],
                        ],
                    ],
                ]);
            }


            Auth::login($user);

            $resultado = [
                'usuario'  => $user,
                'direccion'  => $direccion,
                'datos_universidad'  =>  $datos,
                'codigo_sms' => $numero_aleatorio_message,
                'password' => $password

            ];

            return $this->success($resultado, 200, 'Registro exitoso');
        } catch (\Throwable $th) {
            DB::rollBack();
            Log::error($th);
            return $this->error('Se ha presentado algun error al momento de registrar su cuenta. Por favor contacte al equipo de soporte para más información.', 400);
        }
    }

    public function cambio_contraseña(Request $request, User $user)
    {
        $user->update(['password' => Hash::make($request->password), 'email_verified_at' => now(), 'phone_verified_at' => now()]);

        return $this->success($user, 200);
    }
}
