<?php

namespace App\Http\Requests\Proyectos;

use Illuminate\Foundation\Http\FormRequest;

class CreateProyecto extends FormRequest
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
            'necesidad_id' => 'required|integer',
            'especificacion' => 'nullable|string',
            'clasificacion_id' => 'required|array'
        ];
    }

    public function messages()
    {
        return [
            'necesidad_id.required' => 'Es necesario hacer referencia a la necesidad de la cual se creará el proyecto',
            'clasificacion_id.required' => 'Es necesario clasificar el nuevo proyecto',
        ];
    }
}
