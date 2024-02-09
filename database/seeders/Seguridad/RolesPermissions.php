<?php

namespace Database\Seeders\Seguridad;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesPermissions extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $role1 = Role::create(['name' => 'SUPER_ADMINISTRADOR', 'estatus_id' => 1]);
        $role2 = Role::create(['name' => 'ESTUDIANTE', 'estatus_id' => 1]);
        $role3 = Role::create(['name' => 'COMUNIDAD', 'estatus_id' => 1]);
        $role4 = Role::create(['name' => 'ASESOR', 'estatus_id' => 1]);
        $role5 = Role::create(['name' => 'ADMINISTRADOR_PROYECTO', 'estatus_id' => 1]);


        ///////////////// ADMINISTRADOR_PROYECTO
        Permission::create(['name' => 'Clasificacion_proyectos', 'estatus_id' => 1])->syncRoles([$role1, $role5]);
        Permission::create(['name' => 'Item_evaluativos', 'estatus_id' => 1])->syncRoles([$role1, $role5]);
        Permission::create(['name' => 'Motivos_denegacion', 'estatus_id' => 1])->syncRoles([$role1, $role5]);
        Permission::create(['name' => 'Banco_necesidades', 'estatus_id' => 1])->syncRoles([$role1, $role5]);
        Permission::create(['name' => 'Banco_proyectos', 'estatus_id' => 1])->syncRoles([$role1, $role5, $role4, $role2]);
        Permission::create(['name' => 'Lista_equipos', 'estatus_id' => 1])->syncRoles([$role1, $role4, $role5]);
        Permission::create(['name' => 'Biblioteca_medios', 'estatus_id' => 1])->syncRoles([$role1, $role2, $role3, $role4, $role5]);

        ///////////////// ASESOR
        Permission::create(['name' => 'Lista_proyectos', 'estatus_id' => 1])->syncRoles([$role1, $role3, $role4]);

        ///////////////// ESTUDIANTE
        Permission::create(['name' => 'Generacion_equipos', 'estatus_id' => 1])->syncRoles([$role1, $role2]);
        Permission::create(['name' => 'Historico_equipos', 'estatus_id' => 1])->syncRoles([$role1, $role2]);
        Permission::create(['name' => 'Mi_proyecto', 'estatus_id' => 1])->syncRoles([$role1, $role2]);


        ///////////////// COMUNIDAD
        Permission::create(['name' => 'Mis_necesidades', 'estatus_id' => 1])->syncRoles([$role1, $role3]);

        ////////////////SEGURIDAD

        Permission::create(['name' => 'Usuarios', 'estatus_id' => 1])->syncRoles([$role1]);
        Permission::create(['name' => 'Roles', 'estatus_id' => 1])->syncRoles([$role1]);
        Permission::create(['name' => 'Auditoria', 'estatus_id' => 1])->syncRoles([$role1]);
    }
}
