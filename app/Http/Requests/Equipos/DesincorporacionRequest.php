<?php

namespace App\Http\Requests\Equipos;

use Illuminate\Foundation\Http\FormRequest;

class DesincorporacionRequest extends FormRequest
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
            'motivo' => 'required'
        ];
    }

    public function messages()
    {
        return [
            'motivo.required' => 'Es necesitario explicar a los asesores el motivo de la desincorporación.'
        ];
    }
}
