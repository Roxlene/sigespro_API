<?php

namespace App\Models\proyectos;

use App\Models\Administracion\Estatus;
use App\Models\Proyectos\Equipos;
use App\Models\Proyectos\Integrantes;
use App\Models\Seguridad\Auditoria;
use App\Models\User;
use App\Transformers\UserTransformer;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Facades\DB;

class solicitudes extends Model
{
    use HasFactory;

    public $table = "proyectos.solicitudes";

    protected $fillable = [
        'solicitante_id',
        'equipo_id',
        'id_estatus',
        'integrante_id_desincorporar',
        'user_id',
        'integracion',
        'motivo_desincorporacion',
        'motivo_denegacion'
    ];

    public function usuario()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function solicitante()
    {
        return $this->belongsTo(Integrantes::class, 'solicitante_id');
    }

    public function equipo()
    {
        return $this->belongsTo(Equipos::class, 'equipo_id');
    }

    public static function mandar_solicitud($request)
    {
        try {
            //Busqueda de datos del integrante solicitado
            $user = User::with('persona')->find($request['nuevo_integrante_id']);
            //Datos del equipo
            $Equipo = Integrantes::estatus_equipo();
            // dd($Equipo);
            $Equipo_id = $Equipo->equipo_id;
            $Integrante = $Equipo->integrante_id; //Integrante solicitante solicitante
            // dd($Integrante, $Equipo);

            $descripcion = "Se ha solicitado a: " . strtok($user->persona->nombres, " ") . " " . strtok($user->persona->apellidos, " ") . " unirse al equipo";

            notificaciones::create_notificacion($descripcion, $Equipo_id);

            return static::create([
                'solicitante_id' => $Integrante,
                'equipo_id' => $Equipo_id,
                'user_id' => $user->id
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return null;
        }
    }

    public static function validar_solicitud_existente($solicitado)
    {
        //Busqueda de datos del integrante solicitado
        $user = User::with('persona')->find($solicitado);

        //Datos del equipo
        $Equipo = Integrantes::estatus_equipo();
        $Equipo_id = $Equipo->equipo_id;
        $Integrante = $Equipo->integrante_id; //Integrante solicitante solicitante

        $solicitud = static::wheresolicitante_id($Integrante)->whereEquipo_id($Equipo_id)->where('id_estatus', '<>', Estatus::Solicitud_rechazada)->first();

        return $solicitud != null;
    }

    public static function responder_solicitud($solicitud, $request)
    {
        $user = auth()->user();
        ($request['respuesta'] == true) ? $respuesta = Estatus::Solicitud_aceptada : $respuesta = Estatus::Solicitud_rechazada;

        if ($respuesta == Estatus::Solicitud_aceptada) {
            Integrantes::create([
                'equipo_id' => $solicitud->equipo_id,
                'id_estatus' => 1,
                'user_id' => $solicitud->user_id,
            ]);

            //Cambiar status del equipo ya que se encuentran mas de 1 integrante en él
            ($solicitud->equipo->id_estatus == 9) ? $solicitud->equipo->update(['id_estatus' => Estatus::Activo]) : null;

            $descripcion = strtok($user->persona->nombres, " ") . " " . strtok($user->persona->apellidos, " ") . " aceptó su solicitud para unirse al equipo.";
        } else {
            $descripcion = strtok($user->persona->nombres, " ") . " " . strtok($user->persona->apellidos, " ") . " rechazó su solicitud para unirse al equipo.";
        }

        notificaciones::create_notificacion($descripcion, $solicitud->equipo_id);
        return $solicitud->update(['id_estatus' => $respuesta]);
    }

    public static function solicitar_desincorporacion($integrante, $motivo)
    {
        try {

            $user = UserTransformer::transform(auth()->user());
            $Solicitante_id = $user['integrante_equipo']->integrante_id; //Integrante solicitante

            $user = User::with('persona')->find($integrante->user_id); //Usuario a desincorporar


            $solicitud = static::create([
                'solicitante_id' => $Solicitante_id,
                'integrante_id_desincorporar' => $integrante->id,
                'equipo_id' => $integrante->equipo_id,
                'integracion' => false,
                'motivo_desincorporacion' => $motivo
            ]);
            Auditoria::creacion(
                'Solicitud de desincorporación de integrante',
                'INSERT proyectos.solicitudes',
            );
            $descripcion = "Se ha solicitado desincorporar del equipo a: " . strtok($user->persona->nombres, " ") . " " . strtok($user->persona->apellidos, " ");

            notificaciones::create_notificacion($descripcion, $integrante->equipo_id);

            return $solicitud;
        } catch (\Throwable $th) {
            DB::rollback();
            return null;
        }
    }

    public static function responder_denegacion($request, $solicitud)
    {
        try {
            $user = auth()->user();
            ($request['respuesta'] == true) ? $respuesta = Estatus::Solicitud_aceptada : $respuesta = Estatus::Solicitud_rechazada;

            if ($respuesta == Estatus::Solicitud_aceptada) {

                Auditoria::creacion(
                    'Asesor aceptó desincorporación de integrante',
                    'UPDATE proyectos.equipos',
                );
                //Cambiando el estatus del integrante [Activo => Retirado]
                Integrantes::find($solicitud->integrante_id_desincorporar)
                    ->update(['id_estatus' => Estatus::Retirado]);

                $descripcion = "El asesor: " . strtok($user->persona->nombres, " ") . " " . strtok($user->persona->apellidos, " ") . " aceptó su solicitud de desincorporación.";
            } else {
                Auditoria::creacion(
                    'Asesor denegó desincorporación de integrante',
                    'UPDATE proyectos.equipos',
                );
                $descripcion = "El asesor: " . strtok($user->persona->nombres, " ") . " " . strtok($user->persona->apellidos, " ") . " rechazó su solicitud de desincorporación.";
            }
            //Creando la notificacion
            notificaciones::create_notificacion($descripcion, $solicitud->equipo_id);

            //Respondiendo solicitud
            return $solicitud->update(['id_estatus' => $respuesta, 'motivo_denegacion' => $request['motivo_denegacion']]);
        } catch (\Throwable $th) {
            DB::rollback();
            return null;
        }
    }

    public static function solicitudes_al_equipo()
    {
        $user = UserTransformer::transform(auth()->user());
        if ($user['integrante_equipo']) {
            return static::with('usuario.persona')->whereEquipo_id($user['integrante_equipo']['equipo_id'])->whereIntegracion(true)->get();
        } else {
            return [];
        }
    }

    public static function solicitudes_recibidas()
    {
        return static::with('solicitante.usuario.persona')->whereUser_id(auth()->user()->id)->orderBy('created_at', 'desc')->get();
    }
}
