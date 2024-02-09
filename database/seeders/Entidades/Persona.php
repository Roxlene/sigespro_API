<?php

namespace Database\Seeders\Entidades;

use App\Models\Entidades\Persona as EntidadesPersona;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class Persona extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        EntidadesPersona::create([
            'nombres' => 'Desarrollo',
            'apellidos' => 'Comunidad',
            'cedula' => 'V12345654',
            'fullname' => 'Desarrollo Comunidad',
            'telefono' => '04127081154',
        ]);
    }
}
