<?php

use App\Http\Controllers\Administrativo\ClasificacionProyectosController;
use App\Http\Controllers\Administrativo\ItemsController;
use App\Http\Controllers\Administrativo\ItemsEvaluadosController;
use App\Http\Controllers\Administrativo\MotivosDenegacionController;
use App\Http\Controllers\Auth\AutenticationsController;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\Consultas\MaestrasController;
use App\Http\Controllers\Consultas\UniversidadController;
use App\Http\Controllers\Proyecto\EquiposController;
use App\Http\Controllers\Proyecto\NecesidadesController;
use App\Http\Controllers\Proyecto\ProyectosController;
use App\Http\Controllers\Seguridad\UserController;
use App\Http\Controllers\SMSController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Get -> Universidad
Route::get('universidad/estudiante/{cedula}', [UniversidadController::class, 'Get_estudiantes']);

//Autenticate
Route::post('auth/registers/estudiante', [AutenticationsController::class, 'register_estudiante']);
Route::post('auth/registers/comunidad', [AutenticationsController::class, 'register_comunidad']);
Route::post('Login', [AuthenticatedSessionController::class, 'store']);
Route::post('cambio_contraseña/{user}', [AutenticationsController::class, 'cambio_contraseña']);
Route::post('/send-sms', [SMSController::class, 'sendSms']);


Route::get('estados', [MaestrasController::class, 'Get_estados']);
Route::get('municipios/{id_estado}', [MaestrasController::class, 'Get_municipio']);
Route::get('parroquias/{id_parroquias}', [MaestrasController::class, 'Get_parroquia']);
Route::get('carreras', [MaestrasController::class, 'Get_carreras']);

Route::get('user/me', [AuthenticatedSessionController::class, 'me']);



Route::group(['middleware' => 'jwt.verify'], function () {

    //Perfil
    Route::get('perfil/{user}', [UserController::class, 'perfil']);

    //Maestras
    Route::get('clasificacion/activos', [ClasificacionProyectosController::class, 'index_activos']);
    Route::post('clasificacion_proyectos', [ClasificacionProyectosController::class, 'index']);
    Route::resource('clasificacion', ClasificacionProyectosController::class);
    Route::get('items/activos', [ItemsController::class, 'index_activos']);
    Route::post('items_evaluacion', [ItemsController::class, 'index']);
    Route::resource('items', ItemsController::class);
    Route::get('items_evaluados/activos', [ItemsEvaluadosController::class, 'index_activos']);
    Route::resource('items_evaluados', ItemsEvaluadosController::class);
    Route::get('motivos_denegacion/activos', [MotivosDenegacionController::class, 'index_activos']);
    Route::post('motivos_denegacion_index', [MotivosDenegacionController::class, 'index']);
    Route::resource('motivos_denegacion', MotivosDenegacionController::class);
    Route::get('componentes', [ClasificacionProyectosController::class, 'componentes']);

    //Gestion de necesidades de las comunidades
    Route::post('necesidades/comunidad', [NecesidadesController::class, 'index_comunidad']);
    Route::get('necesidades/denegadas', [NecesidadesController::class, 'index_denegadas']);
    Route::post('banco_necesidades', [NecesidadesController::class, 'index']);
    Route::resource('necesidades', NecesidadesController::class);
    Route::put('necesidades/denegacion/{necesidade}', [NecesidadesController::class, 'denegacion']);

    //Proyecto
    Route::post('proyectos/activos', [ProyectosController::class, 'index']);
    Route::post('proyectos/necesidad', [ProyectosController::class, 'show_por_comunidad']);
    Route::resource('proyectos', ProyectosController::class);
    Route::get('postulacion/{proyecto_id}', [ProyectosController::class, 'postularse']);
    Route::get('equipos/postulados/{proyectoId}', [ProyectosController::class, 'ver_postulados']);
    Route::get('postulados_validacion/{proyectoId}', [ProyectosController::class, 'postulados_validacion']);
    Route::post('asignar_proyecto_equipo', [ProyectosController::class, 'asignar_proyecto_equipo']);

    //Equipos
    Route::get('equipos/asesores', [EquiposController::class, 'equipos_asesores']);
    Route::get('equipo/{equipo}', [EquiposController::class, 'index']);
    Route::resource('equipos', EquiposController::class);
    Route::get('apertura_equipo', [EquiposController::class, 'apertura_equipo']);
    Route::get('respuesta_solicitud/{solicitud}', [EquiposController::class, 'respuesta_solicitudes']);
    Route::get('busqueda_integrantes', [EquiposController::class, 'busqueda_integrantes_disponibles']);
    Route::get('ceder_liderazgo/{integrante}', [EquiposController::class, 'ceder_sm_liderazgo']);
    Route::put('solicitar_desincorporacion/{integrante}', [EquiposController::class, 'solicitar_desincorporacion']);
    Route::put('responder_desincorporacion/{solicitud}', [EquiposController::class, 'responder_desincorporacion']);
    Route::get('busqueda_integrantes_disponibles', [EquiposController::class, 'busqueda_integrantes_disponibles']);
    Route::get('notificaciones', [EquiposController::class, 'notificaciones']);
    Route::get('ver-notificaciones', [EquiposController::class, 'notificaciones_vistas']);
    Route::get('solicitudes_enviadas', [EquiposController::class, 'solicitudes_enviadas']);
    Route::get('solicitudes_recibidas', [EquiposController::class, 'solicitudes_recibidas']);
    Route::get('ver-solicitudes', [EquiposController::class, 'solicitudes_vistas']);
    Route::get('ver-actividades/{equipoId}', [EquiposController::class, 'ver_actividades']);

    //Seguridad
    Route::get('auditoria', [UserController::class, 'auditoria']);
    Route::get('roles', [UserController::class, 'roles']);
    Route::get('permissions', [UserController::class, 'permissions']);
    Route::resource('user', UserController::class);
    Route::post('cambio_image', [UserController::class, 'cambio_image']);
});

/* Route::middleware(['jwt.verify'])->get('/user', function (Request $request) {
    return $request->user();
}); */
