<?php

namespace Database\Seeders\Administracion;

use App\Models\Administracion\Estatus;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class EstatusSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Estatus::create([
            'descripcion' => 'Activo',
            'categoria' => 'General'
        ]);

        Estatus::create([
            'descripcion' => 'Inactivo',
            'categoria' => 'General'
        ]);
    }
}
