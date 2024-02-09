<?php

namespace App\Models;

use App\Models\Administracion\Direccion;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Persona extends Model
{
    use HasFactory;

    public $table = "entidades.persona";

    protected $fillable = [
        'nombres',
        'apellidos',
        'fullname',
        'cedula',
        'telefono',
        'id_direccion',
    ];


    public function direccion()
    {
        return $this->belongsTo(Direccion::class, 'id_direccion');
    }
}
