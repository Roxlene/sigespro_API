<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Administracion\Estatus;
use Database\Seeders\Administracion\Componentes_ProyectosSeed;
use Database\Seeders\Administracion\Direccion;
use Database\Seeders\Administracion\EstatusSeeder;
use Database\Seeders\Administracion\Tipo_usuario;
use Database\Seeders\Entidades\Comunidad;
use Database\Seeders\Entidades\Persona;
use Database\Seeders\Seguridad\Configuraciones;
use Database\Seeders\Seguridad\RolesPermissions;
use Database\Seeders\Seguridad\UserSeeder;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {

        // $this->call(EstatusSeeder::class);
        // $this->call(Tipo_usuario::class);
        // $this->call(Direccion::class);
        $this->call(RolesPermissions::class);
        // $this->call(Persona::class);
        // $this->call(Comunidad::class);
        // $this->call(UserSeeder::class);
        // $this->call(Configuraciones::class);
        // $this->call(Componentes_ProyectosSeed::class);

        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
