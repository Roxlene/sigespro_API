<?php

namespace App\Models\Proyectos;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProyectosClasificados extends Model
{
    use HasFactory;

    public $table = "proyectos.proyecto_clasificado";

    protected $fillable = [
        'proyectos_id',
        'clasificacion_id',
    ];

    public $timestamps = false;

    //Relacion de uno a muchos para proyectos a proyecto_clasificado
    public function proyectos()
    {
        return $this->hasMany(Proyectos::class, 'id', 'proyectos_id');
    }
}
