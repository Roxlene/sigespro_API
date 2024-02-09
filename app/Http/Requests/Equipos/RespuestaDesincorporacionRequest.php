<?php

namespace App\Http\Requests\Equipos;

use Illuminate\Foundation\Http\FormRequest;

class RespuestaDesincorporacionRequest extends FormRequest
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
            'respuesta' => 'required|boolean',
            'motivo_denegacion' => 'nullable|string'
        ];
    }

    public function messages()
    {
        return [
            'respuesta.required' => 'Es necesario seleccionar la respuesta,',
            'respuesta. boolean' => 'La respuesta debe ser boollean, true o false.',
        ];
    }
}
