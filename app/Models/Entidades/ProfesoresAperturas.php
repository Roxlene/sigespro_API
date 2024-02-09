<?php

namespace App\Models\Entidades;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProfesoresAperturas extends Model
{
    use HasFactory;

    public $table = "entidades.profesores_clases_aperturadas";

    protected $fillable = [
        'user_id',
        'clase_aperturada_id',
        'tipo_asesor',
        'id_estatus'
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];
}
