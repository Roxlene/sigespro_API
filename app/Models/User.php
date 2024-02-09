<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use App\Models\Administracion\Estatus;
use App\Models\Administracion\Tipo_usuario;
use App\Models\Entidades\Aperturas;
use App\Models\Entidades\Comunidad;
use App\Models\Entidades\Persona;
use App\Models\Entidades\ProfesoresAperturas;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use Tymon\JWTAuth\Contracts\JWTSubject;
use App\Notifications\RegisterUser;
use App\Notifications\SolicitudEquipo;
use Illuminate\Support\Str;
use App\Transformers\UserTransformer;
use Illuminate\Auth\Events\Registered;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class User extends Authenticatable implements JWTSubject
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles;

    public $table = "seguridad.usuarios";
    public $transformer = UserTransformer::class;
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */

    //ROLES

    const ASESOR = 13;


    protected $fillable = [
        'id_persona',
        'id_tipo_usuario',
        'email',
        'password',
        'email_verified_at',
        'phone_verified_at',
        'password_changed',
        'id_comunidad',
        'id_estatus',
        'foto_url',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    public function persona()
    {
        return $this->belongsTo(Persona::class, 'id_persona');
    }
    public function tipo_usuario()
    {
        return $this->belongsTo(Tipo_usuario::class, 'id_tipo_usuario')->select('descripcion');
    }
    public function datos_universidad()
    {
        return $this->hasMany(Datos::class, 'id_usuario');
    }

    public function clases_asesores()
    {
        return $this->hasMany(ProfesoresAperturas::class, 'user_id');
    }

    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'id_estatus');
    }

    public function is_representante($user)
    {
        return !is_null($user->id_comunidad);
    }

    public function comunidad()
    {
        return $this->belongsTo(Comunidad::class, 'id_comunidad');
    }

    public function hasChangedPassword($user)
    {
        return !is_null($user->password_changed_at);
    }

    public function is_Active($user)
    {
        return  $user->id_estatus == 1;
    }

    public function RegisterUser($password)
    {
        $this->notify(new RegisterUser($password));
    }
    public function Solicitud_equipo()
    {
        $this->notify(new SolicitudEquipo());
    }

    public static function validacion_usuario($request)
    {

        $persona = Persona::whereCedula($request['cedula'])->first();
        if ($persona && static::whereId_persona($persona->id)->whereId_estatus(Estatus::Activo)->first()) {
            return $persona;
        } else {
            return null;
        }
    }

    public static function creacionUsers($request)
    {
        try {
            $persona = Persona::firstOrCreate([
                'cedula' => $request['cedula'],
            ], [

                'nombres' => $request['nombres'],
                'apellidos' => $request['apellidos'],
                'fullname' => $request['nombres'] . ' ' . $request['apellidos'],
                'telefono' => $request['telefono'],
            ]);

            $password = Str::random(10);

            $user = static::create([
                'id_persona' => $persona->id,
                'id_tipo_usuario' => Tipo_usuario::INTERNO,
                'email' => $request['correo'],
                'foto_url' => $request['foto_url'],
                'password' => Hash::make($password),
                'id_estatus' => Estatus::Activo
            ])->assignRole($request['rol']);

            $asesorias_clase = [];

            if ($request['rol'] == User::ASESOR) {
                foreach ($request['atenciones'] as $key => $value) {
                    $clase = Aperturas::firstOrCreate([
                        'carrera' => $value['carrera'],
                        'trayecto' => $value['trayecto'],
                        'seccion' => $value['seccion'],
                    ], [
                        'carrera' => $value['carrera'],
                        'trayecto' => $value['trayecto'],
                        'seccion' => $value['seccion'],
                    ]);

                    $asesorias = ProfesoresAperturas::create([
                        'user_id' => $user->id,
                        'clase_aperturada_id' => $clase->id,
                        'tipo_asesor' => $value['tipo_asesor']
                    ]);

                    $asesorias_clase[] = [
                        "clase" => $clase,
                        "asesoria" => $asesorias
                    ];
                }
            }

            $datos = [
                "user" => $user,
                "asesorias" => $asesorias_clase
            ];

            event(new Registered($user));

            // Envio de correo
            $user->RegisterUser($password);

            return $datos;
        } catch (\Throwable $th) {
            DB::rollBack();
            return null;
        }
    }
}
