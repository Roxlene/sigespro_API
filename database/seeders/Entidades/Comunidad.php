<?php

namespace Database\Seeders\Entidades;

use App\Models\Entidades\Comunidad as EntidadesComunidad;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class Comunidad extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        EntidadesComunidad::create([
            'nombre' => 'Desarrollo',
            'telefono' => '04127081154',
            'id_direccion' => 1,
        ]);
    }
}
