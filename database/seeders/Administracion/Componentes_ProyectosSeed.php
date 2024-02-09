<?php

namespace Database\Seeders\Administracion;

use App\Models\Administracion\Componentes_Proyectos;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class Componentes_ProyectosSeed extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Componentes_Proyectos::create([
            'descripcion' => 'Trabajo de Investigación'
        ]);
        Componentes_Proyectos::create([
            'descripcion' => 'Laminas'
        ]);
        Componentes_Proyectos::create([
            'descripcion' => 'Producto'
        ]);
        Componentes_Proyectos::create([
            'descripcion' => 'Portafolio'
        ]);
    }
}
