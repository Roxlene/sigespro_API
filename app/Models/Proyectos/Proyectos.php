<?php

namespace App\Models\Proyectos;

use App\Models\Administracion\ClasificacionProyectos;
use App\Models\Administracion\Estatus;
use App\Models\Entidades\Necesidades;
use App\Models\Seguridad\Auditoria;
use App\Models\User;
use App\Transformers\UserTransformer;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class Proyectos extends Model
{
    use HasFactory;

    public $table = "proyectos.proyectos";

    protected $fillable = [
        'necesidad_id',
        'especificacion',
        'id_estatus',
        'user_id'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'id_estatus')->select('id', 'descripcion');
    }

    public function necesidad()
    {
        return $this->belongsTo(Necesidades::class, 'necesidad_id');
    }

    public static function proyectos($request)
    {

        return static::select('proyectos.id as proyecto_id', 'comunidad.nombre as comunidad', 'proyectos.*', 'clasificacion.*', 'clasificacion.descripcion as nombre_trayecto', 'estatus.descripcion', 'necesidades.necesidad', 'usuarios.foto_url')
            ->join('proyectos.necesidades', 'necesidades.id', 'proyectos.necesidad_id')
            ->join('seguridad.usuarios', 'usuarios.id', 'necesidades.user_id')
            ->join('entidades.comunidad', 'comunidad.id', 'usuarios.id_comunidad')
            ->join('proyectos.proyecto_clasificado', 'proyecto_clasificado.proyectos_id', 'proyectos.id')
            ->join('administrativo.clasificacion_proyectos as clasificacion', 'clasificacion.id', 'proyecto_clasificado.clasificacion_id')
            ->join('administrativo.estatus', 'estatus.id', 'proyectos.id_estatus')
            ->where('proyecto_clasificado.clasificacion_id', 'like', '%' . $request['clasificacion'] . '%')
            ->where('clasificacion.carrera', $request['carrera'])
            ->where('proyectos.id_estatus', Estatus::En_espera_asignacion)
            ->paginate($request['paginate']);

        /* return static::with('necesidad.user.comunidad')
        ->leftjoin('proyectos.proyecto_clasificado', 'proyecto_clasificado.proyectos_id', 'proyectos.id')
        ->where('proyecto_clasificado.clasificacion_id', $request['clasificacion'])
        ->where('proyectos.id_estatus', Estatus::En_espera_asignacion)
            ->get(); */
    }

    public static function equipos_postulados_count($proyecto_id)
    {
        $equipos = DB::table('seguridad.usuarios as u')
            ->rightJoin('entidades.profesores_clases_aperturadas as pca', 'pca.user_id', '=', 'u.id')
            ->rightJoin('entidades.aperturas as a', 'a.id', '=', 'pca.clase_aperturada_id')
            ->rightJoin('proyectos.equipos as e', function ($join) {
                $join->on('e.trayecto', '=', 'a.trayecto')
                    ->on('e.seccion', '=', 'a.seccion')
                    ->on('e.carrera', '=', 'a.carrera');
            })
            ->where('u.id', '=', auth()->user()->id)
            ->whereIn('e.id_estatus', array(Estatus::Activo, Estatus::Aperturado))
            ->get('e.id');

        // dd($equipos);
        $array = [];
        foreach ($equipos as $key => $value) {
            $array[] = $value->id;
        }

        $postulados = DB::table('proyectos.postulaciones as p')
            ->where('p.proyecto_id', $proyecto_id)
            ->whereIn('p.equipo_id', $array)
            ->count();


        return $postulados;
    }

    public static function equipos_postulados($proyecto_id)
    {
        $equipos = DB::table('seguridad.usuarios as u')
            ->rightJoin('entidades.profesores_clases_aperturadas as pca', 'pca.user_id', '=', 'u.id')
            ->rightJoin('entidades.aperturas as a', 'a.id', '=', 'pca.clase_aperturada_id')
            ->rightJoin('proyectos.equipos as e', function ($join) {
                $join->on('e.trayecto', '=', 'a.trayecto')
                    ->on('e.seccion', '=', 'a.seccion')
                    ->on('e.carrera', '=', 'a.carrera');
            })
            ->where('u.id', '=', auth()->user()->id)
            ->whereIn('e.id_estatus', array(Estatus::Activo, Estatus::Aperturado))
            ->get('e.id');


        $array = [];

        foreach ($equipos as $key => $value) {
            $array[] = $value->id;
        }

        $postulados = static::rightJoin('proyectos.postulaciones as p2', 'p2.proyecto_id', '=', 'proyectos.id')
            ->rightJoin('proyectos.equipos as e', 'e.id', '=', 'p2.equipo_id')
            ->rightJoin('proyectos.integrantes as i', 'i.equipo_id', '=', 'e.id')
            ->rightJoin('seguridad.usuarios as ui', 'ui.id', '=', 'i.user_id')
            ->rightJoin('entidades.persona as p', 'p.id', '=', 'ui.id_persona')
            ->select('p.fullname', 'ui.email', 'p.cedula', 'ui.foto_url', 'e.*')
            ->where('proyectos.id', $proyecto_id)
            ->where('i.scrum_master', true)
            ->whereIn('e.id', $array)
            ->whereIn('e.id_estatus', array(Estatus::Activo, Estatus::Aperturado))
            ->get();

        $proyecto =  static::select('proyectos.id as proyecto_id', 'comunidad.nombre as comunidad', 'proyectos.*', 'clasificacion.*', 'clasificacion.descripcion as nombre_trayecto', 'estatus.descripcion', 'necesidades.necesidad', 'usuarios.foto_url')
            ->join('proyectos.necesidades', 'necesidades.id', 'proyectos.necesidad_id')
            ->join('seguridad.usuarios', 'usuarios.id', 'necesidades.user_id')
            ->join('entidades.comunidad', 'comunidad.id', 'usuarios.id_comunidad')
            ->join('proyectos.proyecto_clasificado', 'proyecto_clasificado.proyectos_id', 'proyectos.id')
            ->join('administrativo.clasificacion_proyectos as clasificacion', 'clasificacion.id', 'proyecto_clasificado.clasificacion_id')
            ->join('administrativo.estatus', 'estatus.id', 'proyectos.id_estatus')
            ->where('proyectos.id', $proyecto_id)
            ->where('proyectos.id_estatus', Estatus::En_espera_asignacion)
            ->first();

        $datos = [
            'equipos' => $postulados,
            'proyectos' => $proyecto
        ];

        return $datos;
    }

    public static function creacion_proyecto($request)
    {

        $necesidad = Necesidades::find($request['necesidad_id']);

        if ($necesidad->id_estatus != 5) {
            $necesidad->update([
                'id_estatus' => Estatus::Aprobado,
            ]);
        }

        $proyecto = static::create([
            'necesidad_id' => $request['necesidad_id'],
            'especificacion' => $request['especificacion'],
            'id_estatus' => Estatus::En_espera_asignacion,
            'user_id' => auth()->user()->id
        ]);

        notificaciones::create_notificacion_terceros('Se creado un proyecto en base a su necesidad ' . $necesidad->cod_necesidad, $necesidad->user_id);
        notificaciones::create_notificacion_terceros('Se creado un proyecto en base a la necesidad ' . $necesidad->cod_necesidad);

        Auditoria::creacion('Creación de proyecto', 'INSERT proyectos.proyectos');


        $clasificacion = [];
        foreach ($request['clasificacion_id'] as $key => $value) {
            $especificacion_de_proyecto = ProyectosClasificados::create([
                'proyectos_id' => $proyecto->id,
                'clasificacion_id' => $value
            ]);
            $clasificacion[] = $especificacion_de_proyecto;
        }

        $data = [
            'necesidad' => $necesidad,
            'proyecto' => $proyecto,
            'clasificacion' => $clasificacion,
        ];

        return $data;
    }

    public static function proyectos_por_comunidad($request)
    {
        return static::select('proyectos.id as proyecto_id', 'comunidad.nombre as comunidad', 'proyectos.*', 'clasificacion.*', 'clasificacion.descripcion as nombre_trayecto', 'estatus.descripcion', 'necesidades.necesidad', 'foto_url')
            ->join('proyectos.necesidades', 'necesidades.id', 'proyectos.necesidad_id')
            ->join('seguridad.usuarios', 'usuarios.id', 'necesidades.user_id')
            ->join('entidades.comunidad', 'comunidad.id', 'usuarios.id_comunidad')
            ->join('proyectos.proyecto_clasificado', 'proyecto_clasificado.proyectos_id', 'proyectos.id')
            ->join('administrativo.clasificacion_proyectos as clasificacion', 'clasificacion.id', 'proyecto_clasificado.clasificacion_id')
            ->join('administrativo.estatus', 'estatus.id', 'proyectos.id_estatus')
            ->where('proyectos.necesidad_id', $request['necesidad_id'])
            ->paginate($request['paginate']);
    }

    public static function asignacion_equipo($request)
    {
        try {
            $equipo = Equipos::where('id', $request['equipo_id'])->update(['proyecto_id' => $request['proyecto_id'], 'id_estatus' => Estatus::En_desarrollo]);
            $proyecto = static::where('id', $request['proyecto_id'])->update(['id_estatus' => Estatus::En_desarrollo]);
            notificaciones::create_notificacion('Asignación de proyecto procesada', $request['equipo_id']);
            ActividadesEquipos::create_actividad('Asignación de proyecto', $request['equipo_id'], $request['proyecto_id']);
            return $equipo;
        } catch (\Throwable $th) {
            Log::error($th);
            return null;
        }
    }

    public static function actualizacion_avances($request, $proyectoId)
    {
        try {
            $user = UserTransformer::transform(auth()->user());


            $archivo = SubidasArchivos::firstOrCreate([
                'proyecto_id' => $proyectoId,
                'equipo_id' => $user['integrante_equipo']['equipo_id'],
            ], [
                'titulo' => $request['titulo'],
                'presentacion' => $request['presentacion'],
                'investigacion' => $request['investigacion'],
                'producto' => $request['producto'],
                'portafolio' => $request['portafolio'],
                'actividad_id' => ActividadesEquipos::create_actividad('Primera actualización de proyecto',  $user['integrante_equipo']['equipo_id'])->id
            ]);

            if ($request['titulo']) {
                $archivo->update([
                    'titulo' => $request['titulo']
                ]);
            }
            if ($request['investigacion']) {
                $archivo->update([
                    'investigacion' => $request['investigacion'],
                    'edicion_trabajo' => $archivo->edicion_trabajo + 1,
                    'actividad_id' => ActividadesEquipos::create_actividad('Actualización de trabajo de investigación',  $user['integrante_equipo']['equipo_id'])->id
                ]);
            }
            if ($request['presentacion']) {
                $archivo->update([
                    'presentacion' => $request['presentacion'],
                    'edicion_laminas' => $archivo->edicion_laminas + 1,
                    'actividad_id' => ActividadesEquipos::create_actividad('Actualización de laminas de presentación',  $user['integrante_equipo']['equipo_id'])->id
                ]);
            }
            if ($request['producto']) {
                $archivo->update([
                    'producto' => $request['producto'],
                    'edicion_producto' => $archivo->edicion_producto + 1,
                    'actividad_id' => ActividadesEquipos::create_actividad('Actualización del producto',  $user['integrante_equipo']['equipo_id'])->id
                ]);
            }
            if ($request['portafolio']) {
                $archivo->update([
                    'portafolio' => $request['portafolio'],
                    'correccion_portafolio' => $archivo->correccion_portafolio + 1,
                    'actividad_id' => ActividadesEquipos::create_actividad('Actualización del portafolio',  $user['integrante_equipo']['equipo_id'])->id
                ]);
            }

            return $archivo;
        } catch (\Throwable $th) {
            return null;
            Log::error($th);
        }
    }
}
