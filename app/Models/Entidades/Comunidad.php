<?php

namespace App\Models\Entidades;

use App\Models\Administracion\Direccion;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comunidad extends Model
{
    use HasFactory;

    public $table = "entidades.comunidad";

    protected $fillable = [
        'rif',
        'nombre',
        'telefono',
        'email',
        'id_direccion'
    ];

    public function direccion()
    {
        return $this->belongsTo(Direccion::class, 'id_direccion');
    }
}
