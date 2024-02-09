<?php

namespace App\Http\Controllers\Consultas;

use App\Http\Controllers\Controller;
use App\Models\Administracion\Estados;
use App\Models\Administracion\Municipios;
use App\Models\Administracion\Parroquia;
use App\Models\Universidad\Carreras;
use Illuminate\Http\Request;

class MaestrasController extends Controller
{
    public function Get_estados()
    {

        $estudiante = Estados::all();
        return $this->success($estudiante, 200);
    }

    public function Get_municipio($id_estado)
    {

        $estudiante = Municipios::whereId_estado($id_estado)->get();
        return $this->success($estudiante, 200);
    }

    public function Get_parroquia($id_municipio)
    {

        $estudiante = Parroquia::whereId_municipio($id_municipio)->get();
        return $this->success($estudiante, 200);
    }

    public function Get_carreras()
    {

        $carreras = Carreras::all();
        return $this->success($carreras, 200, 'carreras encontradas');
    }
}
