<?php

namespace App\Http\Requests\Auth;

use App\Models\Entidades\Comunidad;
use App\Models\Entidades\Persona as EntidadesPersona;
use App\Models\Persona;
use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;

class RegisterRequest extends FormRequest
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
            'rif' => 'nullable|unique:' . Comunidad::class . ',rif',
            'nombre_empresa' => 'required|unique:' . Comunidad::class . ',nombre',
            'estado' => 'required|integer',
            'municipio' => 'required|integer',
            'parroquia' => 'required|integer',
            'detalles' => 'required',
            'prefijo_cedula' => 'required',
            'cedula' => 'required',
            'nombres' => 'required',
            'apellidos' => 'required',
            'email' => 'required|unique:' . User::class . ',email',
            'telefono_empresa' => 'required|unique:' . Comunidad::class . ',telefono',

        ];
    }

    public function messages()
    {
        return [
            'rif.unique' => 'El rif ya ha sido registrado',
            'nombre_empresa.unique' => 'El nombre de su empresa ya ha sido registrado anteriormente',
            'email.unique' => 'El correo electrónico ya ha sido registrado',
            'telefono_empresa.unique' => 'El número telefónico ya ha sido registrado anteriomente por otra comunidad',
        ];
    }
}
