<?php

namespace App\Models\Administracion;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tipo_usuario extends Model
{
    use HasFactory;
    public $table = "administrativo.tipo_usuario";

    const ESTUDIANTE = 1;
    const COMUNIDAD = 2;
    const INTERNO = 3;
}
