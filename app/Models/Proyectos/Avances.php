<?php

namespace App\Models\Proyectos;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Avances extends Model
{
    use HasFactory;

    public $table = 'proyectos.avances_equipos';

    protected $fillable = [
        'equipo_id',
        'item_evaluado_id',
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];
}
