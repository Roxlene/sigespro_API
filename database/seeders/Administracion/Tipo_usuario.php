<?php

namespace Database\Seeders\Administracion;

use App\Models\Administracion\Tipo_usuario as AdministracionTipo_usuario;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class Tipo_usuario extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        AdministracionTipo_usuario::create([
            'descripcion' => 'ESTUDIANTE',
        ]);

        AdministracionTipo_usuario::create([
            'descripcion' => 'COMUNIDAD',
        ]);

        AdministracionTipo_usuario::create([
            'descripcion' => 'TUTOR',
        ]);

        AdministracionTipo_usuario::create([
            'descripcion' => 'ADMINISTRATIVO',
        ]);
    }
}
