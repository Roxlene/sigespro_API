<?php

namespace App\Http\Requests\Auth;

use App\Models\Entidades\Persona;
use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;

class RegisterEstudiante extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */


    public function rules()
    {

        return [
            'prefijo_cedula' => 'required',
            'cedula' => 'required',
            'nombres' => 'required',
            'apellidos' => 'required',
            'estado' => 'required|integer',
            'municipio' => 'required|integer',
            'parroquia' => 'required|integer',
            'detalles' => 'required',
            'carrera' => 'required_if:tipo_usuario,ESTUDIANTE',
            'seccion' => 'required_if:tipo_usuario,ESTUDIANTE',
            'trayecto' => 'required_if:tipo_usuario,ESTUDIANTE|integer',
            'telefono' => 'required|unique:' . Persona::class . ',telefono',
            'email' => 'required|unique:' . User::class . ',email',

        ];
    }

    public function messages()
    {
        return [
            'telefono.unique' => 'El número telefónico ya ha sido registrado anteriomente',
            'email.unique' => 'El correo electrónico ya ha sido registrado',
        ];
    }
}
