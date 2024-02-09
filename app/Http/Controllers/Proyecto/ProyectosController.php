<?php

namespace App\Http\Controllers\Proyecto;

use App\Http\Controllers\Controller;
use App\Http\Requests\Proyectos\CreateProyecto;
use App\Models\Administracion\Clasificacion_componentes_proyectos;
use App\Models\Administracion\Items_evaluados;
use App\Models\Administracion\ProyectoClasificado;
use App\Models\Proyectos\Avances;
use App\Models\Proyectos\Postulaciones;
use App\Models\Proyectos\Proyectos;
use App\Models\Proyectos\ProyectosClasificados;
use App\Models\Proyectos\SubidasArchivos;
use App\Transformers\UserTransformer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ProyectosController extends Controller
{

    public function index(Request $request) // Proyectos por carreras y trayecto sin asignar
    {
        $proyectos = Proyectos::proyectos($request->all());
        return $this->success($proyectos, 200, 'Proyectos encontrados');
    }


    public function store(CreateProyecto $request)
    {
        $proyecto = Proyectos::creacion_proyecto($request->all());
        return $this->success($proyecto, 200, 'Proyecto creado exitosamente');
    }


    public function show_por_comunidad(Request $request)
    {
        $proyecto = Proyectos::proyectos_por_comunidad($request->all());
        return $this->success($proyecto, 200, 'Proyectos encontrados');
    }

    public function show(Proyectos $proyecto) //Visualizar proyecto ya asignado
    {

        $proyecto->necesidad->user->comunidad;
        $avances = Avances::whereEquipo_id($proyecto->id)->get();
        $archivos = SubidasArchivos::whereProyecto_id($proyecto->id)->first();
        $componentes = ProyectoClasificado::select('cp.id', 'cp.descripcion as nombre', 'clasificacion_id', 'c.descripcion', 'c.trayecto', 'c.carrera')
            ->join('administrativo.clasificacion_proyectos as c', 'c.id', 'proyecto_clasificado.clasificacion_id')
            ->join('administrativo.clasificacion_componentes as cc', 'cc.id_clasificacion', 'proyecto_clasificado.clasificacion_id')
            ->join('administrativo.componentes_proyectos as cp', 'cp.id', 'cc.id_componente_proyecto')
            ->whereProyectos_id($proyecto->id)->get();

        $items = Items_evaluados::select('items.descripcion as nombre', 'items.id', 'items_evaluados.porcentaje')
            ->join('administrativo.items', 'items.id', 'items_evaluados.item_id')
            ->whereClasificacion_id($componentes[0]->clasificacion_id)->get();

        $datos =  [
            'proyecto' => $proyecto,
            'avances_escala' => $avances,
            'proyecto' => $proyecto,
            'archivos' => $archivos,
            'titulo' => ($archivos) ? $archivos->titulo : null,
            'componentes' => $componentes,
            'escala_evaluativa' => $items,
        ];
        return $this->success($datos, 200);
    }


    public function update(Request $request, Proyectos $proyecto)
    {
        $content = Proyectos::actualizacion_avances($request->all(), $proyecto->id);
        if ($content) {
            return $this->success($content, 200, 'Proyecto actualizado exitosamente');
        } else {
            return $this->error('Se ha presentado un inconveniente. Coloquese en contacto con el equipo de soporte de la universidad para mas información.', 400);
        }
    }


    public function destroy($id)
    {
        //
    }

    public function postularse($proyecto_id)
    {

        $transform = UserTransformer::transform(auth()->user());

        //Falta validacion para que solo pueda acceder a los proyectos de su clasificacion

        if ($transform['integrante_equipo']['proyecto_id']) {
            return $this->error('El equipo ya posee un proyecto otorgado', 400);
        } else if (Postulaciones::whereEquipo_id($transform['integrante_equipo']['equipo_id'])->whereProyecto_id($proyecto_id)->first()) {
            return $this->error('El equipo ya se ha postulado anteriormente a este proyecto', 400);
        } else {
            $postulacion = Postulaciones::crear_postulacion($proyecto_id);
            return $this->success($postulacion, 200, 'Postulación realizada exitosamente');
        }
    }

    public function postulados_validacion($proyectoId)
    {
        try {
            $postulados = Proyectos::equipos_postulados_count($proyectoId);
            if ($postulados == 0) {
                return $this->error('Aun no existen equipos postulados a este proyecto', 400);
            } else {
                return $this->success($postulados, 200);
            }
        } catch (\Throwable $th) {
            Log::error($th);
            return $this->error('Se ha presentado algún error. Por favor contacte al equipo de soporte para más información.', 400);
        }
    }

    public function ver_postulados($proyectoId)
    {
        try {
            $postulados = Proyectos::equipos_postulados($proyectoId);
            return $this->success($postulados, 200);
        } catch (\Throwable $th) {
            Log::error($th);
            return $this->error($th, 400);
        }
    }

    public function asignar_proyecto_equipo(Request $request)
    {
        try {
            $asignacion = Proyectos::asignacion_equipo($request->all());
            if ($asignacion) {
                return $this->success($asignacion, 200, 'El proyecto fue asignado exitosamente');
            } else {
                return $this->error('Se ha presentado algún error. Por favor contacte al equipo de soporte para más información.', 400);
            }
        } catch (\Throwable $th) {
            Log::error($th);
            return $this->error('Se ha presentado algún error. Por favor contacte al equipo de soporte para más información.', 400);
        }
    }
}
