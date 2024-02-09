<?php

namespace App\Http\Controllers\Administrativo;

use App\Http\Controllers\Controller;
use App\Http\Requests\Administrativo\CreateItem;
use App\Models\Administracion\Estatus;
use App\Models\Administracion\Items;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ItemsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $items = Items::with('estatus', 'user.persona')->where('descripcion', 'like', '%' . $request['search'] . '%')->orderBy('created_at', 'asc')->paginate($request->paginate);
        return $this->success($items, 200, 'Items encontrados');
    }

    public function index_activos()
    {
        $items = Items::whereid_estatus(Estatus::Activo)->get();
        return $this->success($items, 200, 'Items encontrados');
    }


    public function store(CreateItem $request)
    {
        $item = Items::create(['descripcion' => $request->descripcion, 'user_id' => auth()->user()->id]);
        return $this->success($item, 200, 'Item registrado exitosamente');
    }


    public function show(Items $item)
    {
        return $this->success($item, 200, 'Item encontrado');
    }


    public function update(Request $request, Items $item)
    {
        $rules = [
            'descripcion' => 'required|unique:' . Items::class . ',descripcion,' . $item->id,
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'updated' => false,
                'id' => $item->id,
                'message'  => $validator->errors()
            ], 422);
        }

        $item->fill(['descripcion' => $request->descripcion, 'user_id' => auth()->user()->id])->saveOrfail();

        return $this->success($item, 200, 'Item actualizado exitosamente');
    }


    public function destroy(Items $item)
    {
        if ($item->id_estatus == Estatus::Activo) {
            $item->fill(['id_estatus' => Estatus::Inactivo, 'user_id' => auth()->user()->id])->saveOrfail();
            $message = 'Item inactivado exitosamente';
        } else {
            $item->fill(['id_estatus' => Estatus::Activo, 'user_id' => auth()->user()->id])->saveOrfail();
            $message = 'Item activado exitosamente';
        }

        return $this->success($item, 200, $message);
    }
}
