<?php

namespace Database\Seeders\Administracion;

use App\Models\Administracion\Direccion as AdministracionDireccion;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class Direccion extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        AdministracionDireccion::create([
            'id_estado' => 126,
            'id_municipio' => 1691,
            'id_parroquia' => 5804,
            'detalles' => 'Detalles'
        ]);
    }
}
