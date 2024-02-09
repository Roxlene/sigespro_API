<?php

namespace App\Http\Requests\Seguridad;

use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;

class CreateUser extends FormRequest
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
            'cedula' => 'required',
            'nombres' =>  'required',
            'apellidos' =>  'required',
            'correo' =>  'required|unique:' . User::class . ',email',
            'telefono' =>  'required',
            'rol' =>  'required',
            'foto_url' =>  'nullable',
            'atenciones.*.carrera' =>  'required_if:rol,' . User::ASESOR,
            'atenciones.*.trayecto' =>  'required_if:rol,' . User::ASESOR,
            'atenciones.*.seccion' =>  'required_if:rol,' . User::ASESOR,
            'atenciones.*.tipo_asesor' =>  'required_if:rol,' . User::ASESOR,
        ];
    }
}
