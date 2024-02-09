<?php

namespace Database\Seeders\Seguridad;

use App\Models\Administracion\Estatus;
use App\Models\Seguridad\Configuraciones as SeguridadConfiguraciones;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class Configuraciones extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        SeguridadConfiguraciones::create([
            'descripcion' => 'MensajeriaSMS',
            'status' => true
        ]);
    }
}
