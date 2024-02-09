<?php

namespace App\Http\Controllers\Proyecto;

use App\Http\Controllers\Controller;
use App\Http\Requests\Proyecto\CreateNecesidad;
use App\Models\Administracion\Estatus;
use App\Models\Administracion\Motivos_denegacion;
use App\Models\Entidades\Necesidades;
use App\Models\proyectos\notificaciones;
use App\Models\Seguridad\Auditoria;
use Illuminate\Http\Request;

class NecesidadesController extends Controller
{

    public function index(Request $request) //Todas las necesidades en espera
    {
        $necesidades = Necesidades::necesidades_en_espera($request->paginate, $request->search, $request->status);
        return $this->success($necesidades, 200, 'Necesidades encontradas');
    }

    public function index_denegadas() //Todas las necesidades en espera
    {
        $necesidades = Necesidades::necesidades_denegadas();
        return $this->success($necesidades, 200, 'Necesidades encontradas');
    }

    public function index_comunidad(Request $request) //Todas las necesidades del usuario
    {
        // dd($request->paginate);
        $necesidades = Necesidades::necesidades_por_usuario(auth()->user()->id, $request->paginate, $request->search);
        return $this->success($necesidades, 200, 'Necesidades encontradas');
    }


    public function store(CreateNecesidad $request)
    {
        $necesidades = Necesidades::create_necesidad($request->all());

        return $this->success($necesidades, 200, 'Necesidad registrada exitosamente');
    }


    public function show(Necesidades $necesidade)
    {
        $response = [
            "necesidad" => $necesidade,
            "direccion" => $necesidade->direccion,
            "comunidad" => $necesidade->user->persona,
            "evaluado" => $necesidade->evaluado_por,
        ];
        return $this->success($response, 200, 'Necesidad encontrada');
    }

    public function update(Request $request, Necesidades $necesidade)
    {
        $necesidades = Necesidades::update_necesidad($request->all(), $necesidade);
        return $this->success($necesidades, 200, 'Necesidad actualizada exitosamente');
    }


    public function destroy(Necesidades $necesidade)
    {
        if ($necesidade->id_estatus == Estatus::Espera_verificacion) {
            $necesidad = Necesidades::cambio_status($necesidade, Estatus::Inactivo);
            $message = 'Necesidad inactivada exitosamente';
        } else {
            $necesidad = Necesidades::cambio_status($necesidade, Estatus::Espera_verificacion);
            $message = 'Necesidad activada exitosamente';
        }

        return $this->success($necesidad, 200, $message);
    }

    public function denegacion(Request $request, Necesidades $necesidade)
    {
        $motivo = Motivos_denegacion::find($request->motivo_denegacion);
        $necesidades = Necesidades::denegacion_necesidad($necesidade, $request->motivo_denegacion);

        notificaciones::create_notificacion_terceros('Se ha denegado su necesidad ' . $necesidades->cod_necesidad . ' por motivo de: ' . $motivo->descripcion, $necesidades->user_id);

        notificaciones::create_notificacion_terceros('Se ha denegado la necesidad ' . $necesidades->cod_necesidad . ' por motivo de: ' . $motivo->descripcion);

        return $this->success($necesidades, 200, 'Necesidad denegada exitosamente');
    }
}
