<?php

namespace App\Models\Entidades;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Persona extends Model
{
    use HasFactory;
    public $table = "entidades.persona";

    protected $fillable = [
        'nombres',
        'apellidos',
        'cedula',
        'fullname',
        'telefono',
        'id_direccion'
    ];
}
