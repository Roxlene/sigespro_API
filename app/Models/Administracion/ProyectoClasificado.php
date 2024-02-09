<?php

namespace App\Models\Administracion;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProyectoClasificado extends Model
{
    use HasFactory;

    public $table = "proyectos.proyecto_clasificado";

    protected $fillable = [
        'proyecto_id',
        'clasificacion_id',
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];
}
