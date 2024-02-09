<?php

namespace App\Http\Requests\Administrativo;

use App\Models\Administracion\Motivos_denegacion;
use Illuminate\Foundation\Http\FormRequest;

class CreateMotivosDenegacion extends FormRequest
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
            'descripcion' => 'required|unique:' . Motivos_denegacion::class . ',descripcion',
        ];
    }

    public function messages()
    {
        return [
            'descripcion.unique' => 'El motivo de denegación ya ha sido registrado anteriormente',
        ];
    }
}
