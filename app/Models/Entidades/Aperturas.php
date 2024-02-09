<?php

namespace App\Models\Entidades;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Aperturas extends Model
{
    use HasFactory;
    public $table = "entidades.aperturas";

    protected $fillable = [
        'carrera',
        'trayecto',
        'seccion',
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];
}
