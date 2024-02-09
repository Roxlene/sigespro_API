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
        $message = null;
        if ($estudiante = Estados::all()) {
            $message = 'Estados encontrados';
        }
        return $this->success($estudiante, 200, $message);
    }

    public function Get_municipio($id_estado)
    {
        $message = null;
        if ($estudiante = Municipios::whereId_estado($id_estado)->get()) {
            $message = 'Municipios encontrados';
        }
        return $this->success($estudiante, 200, $message);
    }

    public function Get_parroquia($id_municipio)
    {
        $message = null;
        if ($estudiante = Parroquia::whereId_municipio($id_municipio)->get()) {
            $message = 'Parroquias encontradas';
        }
        return $this->success($estudiante, 200, $message);
    }

    public function Get_carreras()
    {

        $carreras = Carreras::all();
        return $this->success($carreras, 200, 'carreras encontradas');
    }
}
