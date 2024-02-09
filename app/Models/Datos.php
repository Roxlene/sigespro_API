<?php

namespace App\Models;

use App\Models\Administracion\Estatus;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Datos extends Model
{
    use HasFactory;

    public $table = "entidades.usuario_datos";

    protected $fillable = [
        'id_usuario',
        'cod_carrera',
        'seccion',
        'trayecto',
        'estatus_id'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_usuario');
    }

    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'estatus_id');
    }
}
