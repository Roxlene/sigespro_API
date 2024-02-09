<?php

namespace App\Models\Proyectos;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubidasArchivos extends Model
{
    use HasFactory;

    public $table = 'proyectos.subida_archivos';

    protected $fillable = [
        'equipo_id',
        'proyecto_id',
        'actividad_id',
        'titulo',
        'presentacion',
        'investigacion',
        'producto',
        'portafolio',
        'edicion_trabajo',
        'edicion_laminas',
        'edicion_producto',
        'edicion_portafolio',
        'correccion_trabajo',
        'correccion_laminas',
        'correccion_producto',
        'correccion_portafolio',
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];
}
