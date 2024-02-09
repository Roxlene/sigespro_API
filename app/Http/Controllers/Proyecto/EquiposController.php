<?php

namespace App\Http\Controllers\Proyecto;

use App\Http\Controllers\Controller;
use App\Http\Requests\Equipos\DesincorporacionRequest;
use App\Http\Requests\Equipos\RespuestaDesincorporacionRequest;
use App\Http\Requests\Equipos\SolicitudIntegrante;
use App\Models\Administracion\Estatus;
use App\Models\Proyectos\Equipos;
use App\Models\Proyectos\Integrantes;
use App\Models\proyectos\notificaciones;
use App\Models\proyectos\solicitudes;
use App\Models\Seguridad\Auditoria;
use App\Models\Seguridad\VistasNotificaciones;
use App\Models\Seguridad\VistasSolicitudes;
use App\Models\User;
use App\Transformers\UserTransformer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EquiposController extends Controller
{

    public function __construct()
    {
        $this->middleware('scrum.master')->only('store', 'ceder_sm_liderazgo', 'solicitar_desincorporacion');
        $this->middleware('estudiante')->except('index', 'notificaciones', 'notificaciones_vistas', 'equipos_asesores', 'ver_actividades');
        // $this->middleware('subscribed')->except('store');
    }

    public function index(Equipos $equipo) //Los integrantes activos del equipo
    {
        $content = $equipo->integrantes()->select('integrantes.*', 'u.email', 'p.fullname', 'p.cedula', 'u.foto_url')
            ->join('seguridad.usuarios as u', 'u.id', 'integrantes.user_id')
            ->join('entidades.persona as p', 'p.id', 'u.id_persona')
            ->where('integrantes.id_estatus', Estatus::Activo)
            ->orderBy('integrantes.scrum_master', 'desc')
            ->get();

        $equipo->estatus;
        $datos = [
            'equipo' => $equipo,
            'integrantes' => $content
        ];

        return $this->success($datos, 200);
    }

    public function equipos_asesores()
    {
        $content = DB::table('seguridad.usuarios as u')
            ->rightJoin('entidades.profesores_clases_aperturadas as pca', 'pca.user_id', '=', 'u.id')
            ->rightJoin('entidades.aperturas as a', 'a.id', '=', 'pca.clase_aperturada_id')
            ->rightJoin('proyectos.equipos as e', function ($join) {
                $join->on('e.trayecto', '=', 'a.trayecto')
                    ->on('e.seccion', '=', 'a.seccion')
                    ->on('e.carrera', '=', 'a.carrera');
            })
            ->rightJoin('proyectos.integrantes as i', 'i.equipo_id', '=', 'e.id')
            ->rightJoin('seguridad.usuarios as ui', 'ui.id', '=', 'i.user_id')
            ->rightJoin('entidades.persona as p', 'p.id', '=', 'ui.id_persona')
            ->rightJoin('administrativo.estatus as es', 'es.id', '=', 'e.id_estatus')
            ->select('p.fullname', 'ui.email', 'p.cedula', 'ui.foto_url', 'e.*', 'es.descripcion')
            ->where('u.id', '=', auth()->user()->id)
            ->where('i.scrum_master', '=', true)
            ->get();

        return $this->success($content, 200);
    }

    public function apertura_equipo()
    {
        if (Integrantes::estatus_equipo()) {
            return $this->goReturn(null, 400, 'Usted ya se encuentra en un equipo activo actualmente');
        } else if (Equipos::validacion_integrantes_disponibles() == false) {
            return $this->goReturn(null, 400, 'No puede aperturar un equipo si no hay integrantes disponibles para unirse.');
        } else {
            $aperturar = Equipos::apertura_equipo();
            return $this->success($aperturar, 200, 'Equipo aperturado exitosamente');
        }
    }

    public function store(SolicitudIntegrante $request) //Envio de solicitudes a compañeros
    {
        if (solicitudes::validar_solicitud_existente($request['nuevo_integrante_id'])) {
            return $this->goReturn(null, 400, 'Usted ya ha enviado una solicitud previa a este usuario para unirse al equipo.');
        }

        $create = solicitudes::mandar_solicitud($request->all());

        if ($create) {
            //Envio de correo de solicitud de equipo
            User::find($request['nuevo_integrante_id'])->Solicitud_equipo();
            return $this->success($create, 200, 'Solicitud enviada exitosamente');
        } else {
            return $this->error('La solicitud no ha sido enviada exitosamente. Intentelo de nuevo', 400);
        }
    }

    public function respuesta_solicitudes(Request $request, solicitudes $solicitud)
    {
        // dd($solicitud->id);
        if ($solicitud->where('id_estatus', '<>', Estatus::En_espera_respuesta)->find($solicitud->id)) {
            return $this->error('Esta solicitud fue respondida anteriormente.', 400);
        } else if (Integrantes::estatus_user_equipo()) {
            return $this->error('Ya usted se encuentra en un equipo de forma activa.', 400);
        }
        $respuesta = solicitudes::responder_solicitud($solicitud, $request->all());
        $transform = UserTransformer::transform(auth()->user());
        if ($respuesta == true && $request['respuesta'] == true) {
            $cant_soli = VistasSolicitudes::where('user_id', auth()->user()->id)->first();

            $cant_soli->update([
                'soli_vistas' => $cant_soli->cant_soli,
                'soli_new' => 0,
            ]);

            return $this->success($transform, 200, 'Solicitud aceptada exitosamente');
        } else {
            return $this->success($transform, 200, 'Solicitud rechazada exitosamente');
        }
    }

    public function busqueda_integrantes_disponibles()
    {
        $content = Equipos::busqueda_nuevos_integrantes();
        return $this->success($content, 200);
    }

    public function show($id)
    {
        //
    }


    public function ver_actividades($equipoId)
    {
        $equipo = Equipos::actividades_equipos($equipoId);
        return $this->success($equipo, 200);
    }


    public function ceder_sm_liderazgo(Integrantes $integrante)
    {
        if ($integrante->user_id == auth()->user()->id) {
            return $this->error('No es posible ceder el rol de liderazgo si ya su usuario lo posee.', 400);
        }

        Equipos::ceder_sm_liderazgo($integrante);


        return $this->success($integrante, 200, 'Rol de Liderazgo cedido exitosamente');
    }

    public function update(Request $request, User $id)
    {
        //
    }

    public function destroy(Equipos $equipo)
    {
        if (count($equipo->integrantes) > 1) {
            return $this->goReturn(null, 400, 'El equipo no se puede eliminar si posee más de una persona integrada');
        } else {
            Auditoria::creacion(
                'Eliminación de equipo',
                'DELETE proyectos.equipos',
            );
            $equipo->notificaciones()->delete();
            $equipo->solicitudes()->delete();
            $equipo->integrantes()->delete();
            $equipo->delete();
            notificaciones::create_notificacion('Eliminación de equipo');
            $content = Equipos::notificaciones_estudiantes();
            $cant_not = VistasNotificaciones::where('user_id', auth()->user()->id)->first();

            $cant_not->update([
                'cant_not' => count($content),
                'not_vistas' => 0,
                'not_new' => 1,
            ]);
            $user =  UserTransformer::transform(auth()->user());
            return $this->success($user, 200, 'Equipo eliminado exitosamente');
        }
    }

    public function solicitar_desincorporacion(DesincorporacionRequest $request, Integrantes $integrante)
    {
        $solicitud = solicitudes::solicitar_desincorporacion($integrante, $request['motivo']);

        if ($solicitud) {
            return $this->success($solicitud, 200, 'Solicitud fue enviada a sus tutores de forma exitosa.');
        } else {
            return $this->error('Se encontró un error enviando su solicitud. Por favor, intentelo de nuevo.', 400);
        }
    }

    public function responder_desincorporacion(RespuestaDesincorporacionRequest $request, solicitudes $solicitud)
    {
        $responder = solicitudes::responder_denegacion($request->all(), $solicitud);
        if ($responder) {
            return $this->success($responder, 200, 'La solicitud fue respondida de forma exitosa.');
        } else {
            return $this->error('Se encontró un error respondiendo la solicitud. Por favor, intentelo de nuevo.', 400);
        }
    }

    public function notificaciones()
    {
        $user = UserTransformer::transform(auth()->user());

        switch ($user['userType']) {
            case 'ESTUDIANTE':
                $content = Equipos::notificaciones_estudiantes();
                break;
            case 'ASESOR':
                $content = Equipos::notificaciones_estudiantes(); //Cambiar
                break;

            default:
                $content = Equipos::notificaciones_generales(); //Cambiar
                break;
        }

        $cant_not = VistasNotificaciones::where('user_id', auth()->user()->id)->first();
        // dd(count($content), $cant_not['cant_not']);

        if (empty($cant_not)) {
            $cant_not = VistasNotificaciones::create([
                'user_id' => auth()->user()->id,
                'cant_not' => count($content),
                'not_vistas' => 0,
                'not_new' => count($content),
            ]);
        } else if ($cant_not->not_new == 0 && count($content) != $cant_not['cant_not']) {
            $cant_new = count($content) - $cant_not->not_vistas;
            $cant_not->update([
                'cant_not' => count($content),
                'not_vistas' => $cant_not->not_vistas,
                'not_new' => $cant_new,
            ]);
        } else if ($cant_not->not_vistas == 0 && count($content) != $cant_not['cant_not']) {
            $cant_not->update([
                'cant_not' => count($content),
                'not_vistas' => 0,
                'not_new' => count($content),
            ]);
        } else if ($cant_not->not_new != 0 && $cant_not->not_vistas != 0 && count($content) != $cant_not['cant_not']) {
            $cant_new = count($content) - $cant_not->not_vistas;
            $cant_not->update([
                'cant_not' => count($content),
                'not_vistas' => $cant_not->not_vistas,
                'not_new' => $cant_new,
            ]);
        }



        $datos = [
            'cantidades' => VistasNotificaciones::where('user_id', auth()->user()->id)->first(),
            'notificaciones' => $content,
        ];


        return $this->success($datos, 200);
    }

    public function notificaciones_vistas()
    {
        $cant_not = VistasNotificaciones::where('user_id', auth()->user()->id)->first();

        $cant_not->update([
            'not_vistas' => $cant_not->cant_not,
            'not_new' => 0,
        ]);

        return $this->success($cant_not, 200);
    }

    public function solicitudes_enviadas()
    {
        $solicitudes = solicitudes::solicitudes_al_equipo();

        return $this->success($solicitudes, 200);
    }

    public function solicitudes_recibidas()
    {
        $user = UserTransformer::transform(auth()->user());

        switch ($user['userType']) {
            case 'ESTUDIANTE':
                $content = solicitudes::solicitudes_recibidas();
                break;

            default:
                $content = [];
                break;
        }

        $cant_soli = VistasSolicitudes::where('user_id', auth()->user()->id)->first();
        // dd(count($content), $cant_soli['cant_soli']);

        if (empty($cant_soli)) {
            $cant_soli = VistasSolicitudes::create([
                'user_id' => auth()->user()->id,
                'cant_soli' => count($content),
                'soli_vistas' => 0,
                'soli_new' => count($content),
            ]);
        } else if ($cant_soli->soli_new == 0 && count($content) != $cant_soli['cant_soli']) {
            $cant_new = count($content) - $cant_soli->soli_vistas;
            $cant_soli->update([
                'cant_soli' => count($content),
                'soli_vistas' => $cant_soli->soli_vistas,
                'soli_new' => $cant_new,
            ]);
        } else if ($cant_soli->soli_vistas == 0 && count($content) != $cant_soli['cant_soli']) {
            $cant_soli->update([
                'cant_soli' => count($content),
                'soli_vistas' => 0,
                'soli_new' => count($content),
            ]);
        } else if ($cant_soli->soli_new != 0 && $cant_soli->soli_vistas != 0 && count($content) != $cant_soli['cant_soli']) {
            $cant_new = count($content) - $cant_soli->soli_vistas;
            $cant_soli->update([
                'cant_soli' => count($content),
                'soli_vistas' => $cant_soli->soli_vistas,
                'soli_new' => $cant_new,
            ]);
        }



        $datos = [
            'cantidades' => VistasSolicitudes::where('user_id', auth()->user()->id)->first(),
            'solicitudes' => $content,
        ];

        return $this->success($datos, 200);
    }

    public function solicitudes_vistas()
    {
        $cant_soli = VistasSolicitudes::where('user_id', auth()->user()->id)->first();

        $cant_soli->update([
            'soli_vistas' => $cant_soli->cant_soli,
            'soli_new' => 0,
        ]);

        return $this->success($cant_soli, 200);
    }
}
