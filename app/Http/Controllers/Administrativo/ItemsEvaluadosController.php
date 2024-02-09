<?php

namespace App\Http\Controllers\Administrativo;

use App\Http\Controllers\Controller;
use App\Http\Requests\Administrativo\CreateItemsEvaluados;
use App\Models\Administracion\Estatus;
use App\Models\Administracion\Items_evaluados;
use Illuminate\Http\Request;

class ItemsEvaluadosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {

        $items = Items_evaluados::with('item')->whereClasificacion_id($request->clasificacion_id)->get();

        return $this->success($items, 200, 'Items encontrados');
    }

    public function index_activos(Request $request)
    {

        $items = Items_evaluados::with('item')->whereClasificacion_id($request->clasificacion_id)->whereId_estatus(Estatus::Activo)->get();

        return $this->success($items, 200, 'Items encontrados');
    }


    public function store(CreateItemsEvaluados $request)
    {

        $item_registrado = Items_evaluados::whereClasificacion_id($request->clasificacion_id)->whereItem_id($request->item_id)->first();

        if ($item_registrado) {
            return $this->message('El item evaluativo ya ha sido registrado para esta carrera y trayecto', 400);
        }

        $item = Items_evaluados::create(['item_id' => $request->item_id, 'porcentaje' => $request->porcentaje, 'clasificacion_id' => $request->clasificacion_id, 'user_id' => auth()->user()->id]);
        return $this->success($item, 200, 'Item evaluativo registrado exitosamente');
    }


    public function show($items_evaluados)
    {
        $items_evaluados = Items_evaluados::find($items_evaluados);
        return $this->success($items_evaluados, 200, 'Item evaluativo encontrado exitosamente');
    }

    public function update(Request $request, $items_evaluados)
    {

        $items_evaluados = Items_evaluados::find($items_evaluados);

        if ($items_evaluados->clasificacion_id != $request->clasificacion_id || $items_evaluados->item_id != $request->item_id) {
            $item_registrado = Items_evaluados::whereClasificacion_id($request->clasificacion_id)->whereItem_id($request->item_id)->first();
            if ($item_registrado) {
                return $this->message('El item evaluativo ya ha sido registrado para esa carrera y trayecto', 400);
            }
        }

        $items_evaluados->fill(['clasificacion_id' => $request->clasificacion_id, 'porcentaje' => $request->porcentaje, 'item_id' => $request->item_id, 'user_id' => auth()->user()->id])->saveOrfail();

        return $this->success($items_evaluados, 200, 'Item evaluativo actualizado exitosamente');
    }

    public function destroy($items_evaluados)
    {
        $item = Items_evaluados::find($items_evaluados);

        if ($item->id_estatus == Estatus::Activo) {
            $item->fill(['id_estatus' => Estatus::Inactivo, 'user_id' => auth()->user()->id])->saveOrfail();
            $message = 'Item evaluativo inactivado exitosamente';
        } else {
            $item->fill(['id_estatus' => Estatus::Activo, 'user_id' => auth()->user()->id])->saveOrfail();
            $message = 'Item evaluativo activado exitosamente';
        }

        return $this->success($item, 200, $message);
    }
}
