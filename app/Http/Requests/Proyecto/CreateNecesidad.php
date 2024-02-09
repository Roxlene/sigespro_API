<?php

namespace App\Http\Requests\Proyecto;

use App\Models\Entidades\Necesidades;
use Illuminate\Foundation\Http\FormRequest;

class CreateNecesidad extends FormRequest
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
            'necesidad' => 'required|unique:' . Necesidades::class . ',necesidad',
            'estado_id' => 'required',
            'municipio_id' => 'required',
            'parroquia_id' => 'required',
            'direccion' => 'required',

        ];
    }

    public function messages()
    {
        return [
            'necesidad.unique' => 'La necesidad que intenta registrar ya ha sido insertada anteriormente',
            'necesidad.required' => 'Es necesario registrar la necesidad de una forma detallada',
            'estado_id.required' => 'Es necesario registrar el estado en donde desea que se atienda su necesidad',
            'municipio_id.required' => 'Es necesario registrar el municipio en donde desea que se atienda su necesidad',
            'parroquia_id.required' => 'Es necesario registrar la parroquia en donde desea que se atienda su necesidad',
            'direccion.required' => 'Es necesario registrar la direccion exacta en donde desea que se atienda su necesidad',
        ];
    }
}
