<?php

namespace App\Http\Requests\Administrativo;

use Illuminate\Foundation\Http\FormRequest;

class ClasificacionProyectosRequest extends FormRequest
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
            'trayecto' => 'required',
            'descripcion' => 'required',
            'carrera' => 'required',
            'items' => 'required|array',
            'componentes' => 'required|array',
        ];
    }
}
