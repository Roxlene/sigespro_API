<?php

namespace App\Models\Administracion;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Clasificacion_componentes_proyectos extends Model
{
    use HasFactory;

    public $table = "administrativo.clasificacion_componentes";

    protected $fillable = [
        'id_clasificacion',
        'id_componente_proyecto',
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];
}
