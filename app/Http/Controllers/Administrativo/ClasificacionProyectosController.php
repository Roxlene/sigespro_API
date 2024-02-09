<?php

namespace App\Http\Controllers\Administrativo;

use App\Http\Controllers\Controller;
use App\Http\Requests\Administrativo\ClasificacionProyectosRequest;
use App\Models\Administracion\Clasificacion_componentes_proyectos;
use App\Models\Administracion\ClasificacionProyectos;
use App\Models\Administracion\Componentes_Proyectos;
use App\Models\Administracion\Estatus;
use App\Models\Administracion\Items_evaluados;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ClasificacionProyectosController extends Controller
{

    public function index(Request $request) // volver post
    {

        if ($request->status) {
            $clasificacion = ClasificacionProyectos::with('estatus')->whereCarrera($request->carrera)->whereId_estatus($request->status)->orderBy('created_at', 'asc')->paginate($request->paginate);
        } else {
            $clasificacion = ClasificacionProyectos::with('estatus')->whereCarrera($request->carrera)->orderBy('created_at', 'asc')->paginate($request->paginate);
        }
        return $this->success($clasificacion, 200, 'Clasificación encontrada');
    }

    public function index_activos(Request $request)
    {

        $clasificacion = ClasificacionProyectos::whereCarrera($request->carrera)->whereId_estatus(Estatus::Activo)->get();
        return $this->success($clasificacion, 200, 'Clasificación encontrada');
    }


    public function store(ClasificacionProyectosRequest $request)
    {
        if (ClasificacionProyectos::whereDescripcion($request->descripcion)->whereCarrera($request->carrera)->whereTrayecto($request->trayecto)->first()) {
            return $this->error('Esta clasificación ya fue anexada anteriormente', 400);
        }
        $create = ClasificacionProyectos::create($request->all());

        $item_nuevos_id = [];

        foreach ($request->items as $key => $value) {
            Items_evaluados::create([
                'item_id' => $value['id'],
                'porcentaje' => $value['porcentaje'],
                'clasificacion_id' => $create->id,
                'user_id' => auth()->user()->id
            ]);
        }

        foreach ($request->componentes as $key => $value) {
            Clasificacion_componentes_proyectos::create([
                'id_componente_proyecto' => $value,
                'id_clasificacion' => $create->id
            ]);
        }

        $items = Items_evaluados::whereClasificacion_id($create->id)->get();
        $componentes = Clasificacion_componentes_proyectos::whereId_clasificacion($create->id)->get();

        $datos = [
            'clasificacion' => $create,
            'items' => $items,
            'componentes' => $componentes
        ];

        return $this->success($datos, 200, 'Clasificación agregada exitosamente');
    }

    public function show($id)
    {
        $clasificacion = ClasificacionProyectos::find($id);

        $items = Items_evaluados::select('items.descripcion as nombre', 'items.id', 'items_evaluados.porcentaje')
            ->join('administrativo.items', 'items.id', 'items_evaluados.item_id')
            ->whereClasificacion_id($id)->get();

        $componentes = Clasificacion_componentes_proyectos::select('cp.id', 'cp.descripcion as nombre')
            ->join('administrativo.componentes_proyectos as cp', 'cp.id', 'clasificacion_componentes.id_componente_proyecto')
            ->whereId_clasificacion($id)->get();

        $datos = [
            'clasificacion' => $clasificacion,
            'items' => $items,
            'componentes' => $componentes
        ];

        return $this->success($datos, 200, 'Clasificación encontrada');
    }

    public function update(ClasificacionProyectosRequest $request, $id)
    {
        if (ClasificacionProyectos::whereCarrera($request->carrera)->whereTrayecto($request->trayecto)->where('id', '<>', $id)->first()) {
            return $this->error('Esta clasificación ya fue anexada anteriormente', 400);
        }

        $clasificacion = ClasificacionProyectos::find($id);
        $clasificacion->fill($request->all())->saveOrfail();

        $items_request = $request->items;

        foreach ($request->items as $key => $value) {
            Items_evaluados::whereClasificacion_id($clasificacion->id)
                ->whereItem_id($value['id'])
                ->where('porcentaje', '<>', $value['porcentaje'])
                ->update([
                    'porcentaje' => $value['porcentaje']
                ]);
            $item_nuevos_id[] = $value['id'];
        }

        $items = Items_evaluados::whereClasificacion_id($clasificacion->id)->get();

        foreach ($items as $key => $value) {
            $item_registrados[] = $value['item_id'];
        }


        $item_borrados = array_diff($item_registrados, $item_nuevos_id);
        $item_nuevos = array_diff($item_nuevos_id, $item_registrados);

        $Busqueda = array_filter($items_request, function ($objeto) use ($item_nuevos) {
            return in_array($objeto['id'], $item_nuevos);
        });


        Items_evaluados::whereClasificacion_id($clasificacion->id)->whereIn('item_id', $item_borrados)->delete();

        foreach ($Busqueda as $key => $value) {
            Items_evaluados::create([
                'item_id' => $value['id'],
                'porcentaje' => $value['porcentaje'],
                'clasificacion_id' => $clasificacion->id
            ]);
        }

        $componentes = Clasificacion_componentes_proyectos::whereId_clasificacion($clasificacion->id)->get();
        foreach ($componentes as $key => $value) {
            $componentes_registrados[] = $value['id_componente_proyecto'];
        }

        $componentes_borrados = array_diff($componentes_registrados, $request->componentes);
        $componentes_nuevos = array_diff($request->componentes, $componentes_registrados);

        $Busqueda = array_filter($request->componentes, function ($objeto) use ($componentes_nuevos) {
            return in_array($objeto, $componentes_nuevos);
        });


        Clasificacion_componentes_proyectos::whereId_clasificacion($clasificacion->id)->whereIn('id_componente_proyecto', $componentes_borrados)->delete();

        foreach ($Busqueda as $key => $value) {
            Clasificacion_componentes_proyectos::create([
                'id_componente_proyecto' => $value,
                'id_clasificacion' => $clasificacion->id
            ]);
        }

        $datos = [
            'clasificacion' => $clasificacion,
            'items' => Items_evaluados::whereClasificacion_id($clasificacion->id)->get(),
            'componentes' => Clasificacion_componentes_proyectos::whereId_clasificacion($clasificacion->id)->get()
        ];

        return $this->success($datos, 200, 'Clasificación modificada exitosamente');
    }


    public function destroy($id)
    {
        $clasificacion = ClasificacionProyectos::find($id);
        if ($clasificacion->id_estatus == Estatus::Activo) {
            $clasificacion->update(['id_estatus' => Estatus::Inactivo]);
            Items_evaluados::whereClasificacion_id($clasificacion->id)
                ->update(['id_estatus' => Estatus::Inactivo]);
            $message = 'Clasificación inactivada exitosamente';
        } else {
            $clasificacion->update(['id_estatus' => Estatus::Activo]);
            Items_evaluados::whereClasificacion_id($clasificacion->id)
                ->update(['id_estatus' => Estatus::Activo]);
            $message = 'Clasificación activada exitosamente';
        }
        return $this->success($clasificacion, 200, $message);
    }

    public function componentes()
    {
        $componentes = DB::table('administrativo.componentes_proyectos')->where('id_estatus', Estatus::Activo)->get();
        return $this->success($componentes, 200);
    }
}
