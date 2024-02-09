<?php

namespace App\Transformers;

use App\Models\Administracion\Direccion;
use App\Models\Administracion\Estatus;
use App\Models\GestionSnv\Administration\RegionalOffices;
use App\Models\Role;
use App\Models\User;
use App\Models\GestionSnv\TypeParticipant;
use App\Models\Proyectos\Integrantes;
use Illuminate\Support\Arr;
use League\Fractal\TransformerAbstract;
use Spatie\Permission\Models\Role as ModelsRole;

class UserTransformer extends TransformerAbstract
{

    /**
     * A Fractal transformer.
     *
     * @return array
     */
    public static function transform(User $user)
    {
        /*         dd(Integrantes::estatus_equipo(), auth()->user()->id);
 */
        ($user->tipo_usuario->descripcion == 'ESTUDIANTE') ?
            $direccion = Direccion::with('estado',  'municipio', 'parroquia')->find($user->persona->id_direccion)
            : [($user->tipo_usuario->descripcion == 'COMUNIDAD') ?
                $direccion = Direccion::with('estado',  'municipio', 'parroquia')->find($user->comunidad->id_direccion)
                : $direccion = NULL];

        $response = [
            'id' => $user->id,
            'isActive' => $user->is_Active($user),
            'profile_photo_url' => $user->foto_url,
            'userType' => ($user->tipo_usuario->descripcion == 'INTERNO') ? $user->getRoleNames()[0] : $user->tipo_usuario->descripcion,
            'Estatus_equipo' => ($user->tipo_usuario->descripcion == 'ESTUDIANTE') ? $equipo = Integrantes::estatus_user_equipo() : null,
            'scrum_master' => ($user->tipo_usuario->descripcion == 'ESTUDIANTE' && $equipo == true) ? Integrantes::estatus_scrum_master() : false,
            'integrante_equipo' => ($user->tipo_usuario->descripcion == 'ESTUDIANTE' && $equipo == true) ? Integrantes::estatus_equipo() : null,
            'proyecto' => ($user->tipo_usuario->descripcion == 'ESTUDIANTE' && $equipo == true) ? Integrantes::estatus_equipo()->proyecto_id : null,
            'cedula' => $user->persona->cedula,
            'nombres' => $user->persona->nombres,
            'apellidos' => $user->persona->apellidos,
            'nombre_completo' => $user->persona->fullname,
            'comunidad' => ($user->comunidad) ? $user->comunidad->nombre : null,
            'email' => $user->email,
            'telefono' => ($user->comunidad) ? $user->comunidad->telefono : $user->persona->telefono,
            'fecha_creacion' => $user->created_at,
            'direccion' => $direccion,
            'roles' => $user->getRoleNames(),
            'abilities' => $user->getAllPermissions(),
            //'oficina' => $oficinas,
            'hasChangedPassword' => $user->hasChangedPassword($user),
            'hasverifyEmail' => $user->hasChangedPassword($user),
            'datos_universitarios' => ($user->tipo_usuario->descripcion == 'ESTUDIANTE') ?
                $user->datos_universidad->where('estatus_id', Estatus::Activo)->first()
                : NULL,


        ];



        return $response;
    }
}
