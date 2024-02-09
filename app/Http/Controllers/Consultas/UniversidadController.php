<?php

namespace App\Http\Controllers\Consultas;

use App\Http\Controllers\Controller;
use App\Models\Administracion\Tipo_usuario;
use App\Models\Entidades\Persona;
use App\Models\Universidad\Estudiantes;
use App\Models\User;
use Illuminate\Http\Request;

class UniversidadController extends Controller
{
    public function Get_estudiantes($cedula)
    {

        $estudiante = Estudiantes::whereCedula($cedula)->first();

        if (isset($estudiante) && $estudiante->estado == "1" && $estudiante->trayecto != "0") {
            $persona = Persona::whereCedula($cedula)->first();
            $tipo_usuario = Tipo_usuario::whereDescripcion('ESTUDIANTE')->first();
            if (isset($persona) && User::whereId_persona($persona->id)->whereId_tipo_usuario($tipo_usuario->id)->first()) {
                return $this->message('El estudiante ya se encuentra registrado', 200);
            } else {
                $data = [
                    "cedula"    => trim($estudiante->cedula),
                    "nombres"   => trim($estudiante->nombres),
                    "apellidos" => trim($estudiante->apellidos),
                    "cod_carr"  => trim($estudiante->cod_carr),
                    "estado"    => trim($estudiante->estado),
                    "seccion"   => trim($estudiante->seccion),
                    "trayecto"  => trim($estudiante->trayecto)
                ];
                return $this->success($data, 200, 'El estudiante encontrado');
            }
        } elseif (isset($estudiante) && $estudiante->estado != '1') {
            return $this->message('El estudiante no se encuentra en un estatus ACTIVO', 200);
        } elseif (isset($estudiante) && $estudiante->trayecto == '0') {
            return $this->message('El estudiante aun se encuentra en trayecto inicial', 200);
        } else {
            return $this->error('Estudiante no encontrado', 200);
        }
    }
}
