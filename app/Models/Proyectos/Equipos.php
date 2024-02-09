<?php

namespace App\Models\Proyectos;

use App\Models\Administracion\Estatus;
use App\Models\Datos;
use App\Models\proyectos\notificaciones;
use App\Models\proyectos\solicitudes;
use App\Models\Seguridad\Auditoria;
use App\Models\User;
use App\Transformers\UserTransformer;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class Equipos extends Model
{
    use HasFactory;

    public $table = "proyectos.equipos";

    protected $fillable = [
        'trayecto',
        'carrera',
        'seccion',
        'proyecto_id',
        'id_estatus',
        'user_id'
    ];

    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'id_estatus')->select('id', 'descripcion');
    }

    public function solicitudes()
    {
        // Define la relación 'hasMany' con el modelo Solicitud
        return $this->hasMany(solicitudes::class, 'equipo_id');
    }
    public function notificaciones()
    {
        // Define la relación 'hasMany' con el modelo Solicitud
        return $this->hasMany(notificaciones::class, 'equipo_id');
    }

    public function integrantes()
    {
        return $this->hasMany(Integrantes::class, 'equipo_id');
    }

    public static function apertura_equipo()
    {

        $datos_universitarios = auth()->user()->datos_universidad->where('estatus_id', Estatus::Activo)->first();

        try {
            $equipo = static::create([
                'trayecto' => $datos_universitarios->trayecto,
                'carrera' => $datos_universitarios->cod_carrera,
                'seccion' => $datos_universitarios->seccion,
                'id_estatus' => Estatus::Aperturado,
                'user_id' => auth()->user()->id,
            ]);

            $integrante = Integrantes::create([
                'equipo_id' => $equipo->id,
                'scrum_master' => true,
                'id_estatus' => 1,
                'user_id' => auth()->user()->id,
            ]);

            $notificacion = notificaciones::create_notificacion('Creación de equipo');
            Auditoria::creacion('Apertura de equipo', 'INSERT proyectos.equipos');
            ActividadesEquipos::create_actividad('Apertura de equipo',  $equipo->id);


            return $datos = [
                'equipo' => $equipo,
                'integrante' => $integrante,
                'user' => UserTransformer::transform(auth()->user())

            ];
        } catch (\Throwable $th) {
            DB::rollBack();
        }
    }

    public static function busqueda_nuevos_integrantes()
    {
        $usuarioId = auth()->user()->id;
        $estatusId = Estatus::Activo;

        $usuarios = User::leftJoin('entidades.persona as p', 'p.id', '=', 'usuarios.id_persona')
            ->leftJoin('proyectos.integrantes as i', 'usuarios.id', '=', 'i.user_id')
            ->leftJoin('entidades.usuario_datos as du', 'usuarios.id', '=', 'du.id_usuario')
            ->leftJoin('proyectos.equipos as e', 'e.id', '=', 'i.equipo_id')
            ->where('usuarios.id_tipo_usuario', 1)
            ->where(function ($query) use ($estatusId) {
                $query->whereNull('i.user_id')
                    ->orWhere('i.id_estatus', '<>', $estatusId);
            })
            ->Where(function ($query) use ($usuarioId, $estatusId) {
                $query->where('du.seccion', Datos::where('id_usuario', $usuarioId)->where('estatus_id', $estatusId)->value('seccion'))
                    ->where('du.trayecto', Datos::where('id_usuario', $usuarioId)->where('estatus_id', $estatusId)->value('trayecto'))
                    ->where('du.cod_carrera', Datos::where('id_usuario', $usuarioId)->where('estatus_id', $estatusId)->value('cod_carrera'))
                    ->where('usuarios.id', '<>', $usuarioId);
            })
            ->select('p.fullname', 'p.cedula', 'usuarios.*', 'du.*')
            ->get();

        Auditoria::creacion('Consulta de estudiantes disponibles para solicitar integrantes para el equipo', 'SELECT usuarios');

        return $usuarios;
    }

    public static function validacion_integrantes_disponibles()
    {
        return count(static::busqueda_nuevos_integrantes()) > 0;
    }
    public static function ceder_sm_liderazgo($integrante)
    {
        Integrantes::whereUser_id(auth()->user()->id)->whereEquipo_id($integrante->equipo_id)->update(['scrum_master' => false]);
        $integrante->update(['scrum_master' => true]);
        $descripcion = strtok(auth()->user()->persona->nombres, " ") . " " . strtok(auth()->user()->persona->apellidos, " ") . " ha cedido el rol de Liderazgo/ Scrum Master del equipo";
        $notificacion = notificaciones::create_notificacion($descripcion, $integrante->equipo_id);
        Auditoria::creacion($descripcion, 'UPDATE proyectos.integrantes');

        Auditoria::creacion(
            'Nuevo Srum Master/ lider de equipo: ' . $integrante->usuario->persona->fullname,
            'UPDATE proyectos.integrantes',
        );


        return $integrante;
    }

    public static function notificaciones_estudiantes()
    {
        $usuario_id = auth()->user()->id;
        $usuario = UserTransformer::transform(auth()->user());
        $estatusId = Estatus::Activo;

        if ($usuario['integrante_equipo']) {
            $usuarios = DB::table('proyectos.notificaciones')
                ->where(function ($query) use ($usuario, $usuario_id) {
                    $query->where('user_id', $usuario_id)
                        ->whereNull('equipo_id');
                })
                ->orWhere(function ($query)  use ($usuario, $usuario_id) {
                    $query->where('user_id', '<>', $usuario_id)
                        ->where('equipo_id', $usuario['integrante_equipo']['equipo_id']);
                })
                ->orWhere(function ($query)  use ($usuario, $usuario_id) {
                    $query->where('user_id', $usuario_id)
                        ->where('equipo_id', $usuario['integrante_equipo']['equipo_id']);
                })
                ->orderBy('created_at', 'desc')
                ->get();
        } else {
            $usuarios = DB::table('proyectos.notificaciones')
                ->where(function ($query) use ($usuario, $usuario_id) {
                    $query->where('user_id', $usuario_id)
                        ->whereNull('equipo_id');
                })
                ->orderBy('created_at', 'desc')
                ->get();
        }



        return $usuarios;
    }
    public static function notificaciones_generales()
    {
        $usuario_id = auth()->user()->id;
        $usuario = UserTransformer::transform(auth()->user());
        $estatusId = Estatus::Activo;

        $usuarios = DB::table('proyectos.notificaciones')
            ->where(function ($query) use ($usuario, $usuario_id) {
                $query->where('user_id', $usuario_id)
                    ->whereNull('equipo_id');
            })
            ->orderBy('created_at', 'desc')
            ->get();




        return $usuarios;
    }

    public static function actividades_equipos($equipoId)
    {
        try {
            return ActividadesEquipos::with('usuario.persona', 'usuario.clases_asesores', 'respuestas.usuario.persona')->whereActividad_padre(null)->whereEstatus_id(Estatus::Activo)->whereEquipo_id($equipoId)->get();
        } catch (\Throwable $th) {
            Log::error($th);
            return null;
        }
    }
}
