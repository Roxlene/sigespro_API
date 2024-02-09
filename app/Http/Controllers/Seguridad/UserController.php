<?php

namespace App\Http\Controllers\Seguridad;

use App\Http\Controllers\Controller;
use App\Http\Requests\Seguridad\CreateUser;
use App\Models\Administracion\Estatus;
use App\Models\Administracion\Tipo_usuario;
use App\Models\Entidades\ProfesoresAperturas;
use App\Models\User;
use App\Transformers\UserTransformer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{

    public function index()
    {
        $asesores = User::role('ASESOR')->whereId_estatus(Estatus::Activo)->count();
        $administradores_proyecto = User::role('ADMINISTRADOR_PROYECTO')->whereId_estatus(Estatus::Activo)->count();
        $comunidades = User::role('COMUNIDAD')->whereId_estatus(Estatus::Activo)->count();
        $estudiantes = User::role('ESTUDIANTE')->whereId_estatus(Estatus::Activo)->count();
        $users = User::with('persona', 'roles')->whereId_tipo_usuario(Tipo_usuario::INTERNO)->get();

        $datos = [
            'asesores' => $asesores,
            'administradores_proyecto' => $administradores_proyecto,
            'comunidades' => $comunidades,
            'estudiantes' => $estudiantes,
            'users' => $users,
        ];
        return $this->success($datos, 200);
    }

    public function store(CreateUser $request)
    {

        if (User::validacion_usuario($request)) {
            return $this->error('Este usuario ya posee un usuario creado y activo.', 400);
        }
        // return $request->all();
        $create = User::creacionUsers($request);

        if ($create) {
            return $this->success($create, 200, 'Usuario creado satisfactoriamente.');
        } else {
            return $this->error('Se ha presentado un error, intentelo más tarde.', 400);
        }
    }

    public function show(User $user)
    {
        $user->persona;
        $datos = [
            'user' => $user,
            'rol' => $user->roles,
            'aperturas' => ($user->getRoleNames()[0] == 'ASESOR') ? ProfesoresAperturas::whereUser_id($user->id)->whereId_estatus(Estatus::Activo)->get() : NULL,

        ];

        return $this->success($datos, 200);
    }

    public function update(Request $request, $id)
    {
        //
    }

    public function destroy($id)
    {
        //
    }

    public function roles()
    {
        $roles = Role::select('id', 'name')->whereEstatus_id(Estatus::Activo)->get();
        return $this->success($roles, 200);
    }

    public function permissions()
    {
        $permissions = Permission::select('id', 'name')->whereEstatus_id(Estatus::Activo)->get();
        return $this->success($permissions, 200);
    }

    public function cambio_image(Request $request)
    {

        $user = auth()->user();
        $user->update(['foto_url' => $request->img]);
        return $this->success(UserTransformer::transform($user), 200, 'Cambio exitoso.');
    }

    public function perfil(User $user)
    {
        $transform = UserTransformer::transform($user);
        return $this->success($transform, 200);
    }

    public function auditoria()
    {
        $content = DB::table('seguridad.auditoria')->get();

        return $this->success($content, 200);
    }
}
