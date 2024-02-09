<?php

namespace App\Http\Requests\Administrativo;

use App\Models\Administracion\Items;
use Illuminate\Foundation\Http\FormRequest;

class CreateItem extends FormRequest
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
            'descripcion' => 'required|unique:' . Items::class . ',descripcion',
        ];
    }

    public function messages()
    {
        return [
            'descripcion.unique' => 'El item de evaluación ya ha sido registrado anteriormente',
        ];
    }
}
