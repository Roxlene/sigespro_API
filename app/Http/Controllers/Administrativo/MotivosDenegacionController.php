<?php

namespace App\Http\Controllers\Administrativo;

use App\Http\Controllers\Controller;
use App\Http\Requests\Administrativo\CreateMotivosDenegacion;
use App\Models\Administracion\Estatus;
use App\Models\Administracion\Motivos_denegacion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MotivosDenegacionController extends Controller
{
    public function index(Request $request)
    {
        $motivos = Motivos_denegacion::where('descripcion', 'like', '%' . $request['search'] . '%')->paginate($request['paginate']);
        return $this->success($motivos, 200, 'Motivos de denegación encontrados');
    }

    public function index_activos()
    {
        $motivos = Motivos_denegacion::whereid_estatus(Estatus::Activo)->get();
        return $this->success($motivos, 200, 'Motivos de denegación encontrados');
    }


    public function store(CreateMotivosDenegacion $request)
    {
        $motivos = Motivos_denegacion::create(['descripcion' => $request->descripcion, 'user_id' => auth()->user()->id]);
        return $this->success($motivos, 200, 'Motivo de denegación registrado exitosamente');
    }


    public function show(Motivos_denegacion $motivos_denegacion)
    {
        return $this->success($motivos_denegacion, 200, 'Motivo de denegación encontrado');
    }


    public function update(Request $request, Motivos_denegacion $motivos_denegacion)
    {
        $rules = [
            'descripcion' => 'required|unique:' . Motivos_denegacion::class . ',descripcion,' . $motivos_denegacion->id,
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'status' => 422,
                'updated' => false,
                'id' => $motivos_denegacion->id,
                'message'  => $validator->errors()
            ], 422);
        }

        $motivos_denegacion->fill(['descripcion' => $request->descripcion, 'user_id' => auth()->user()->id])->saveOrfail();

        return $this->success($motivos_denegacion, 200, 'Motivo de denegación actualizado exitosamente');
    }


    public function destroy(Motivos_denegacion $motivos_denegacion)
    {
        if ($motivos_denegacion->id_estatus == Estatus::Activo) {
            $motivos_denegacion->fill(['id_estatus' => Estatus::Inactivo, 'user_id' => auth()->user()->id])->saveOrfail();
            $message = 'Motivo de denegación inactivado exitosamente';
        } else {
            $motivos_denegacion->fill(['id_estatus' => Estatus::Activo, 'user_id' => auth()->user()->id])->saveOrfail();
            $message = 'Motivo de denegación activado exitosamente';
        }

        return $this->success($motivos_denegacion, 200, $message);
    }
}
