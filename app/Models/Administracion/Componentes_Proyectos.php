<?php

namespace App\Models\Administracion;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Componentes_Proyectos extends Model
{
    use HasFactory;

    public $table = "administrativo.componentes_proyectos";

    protected $fillable = [
        'descripcion'
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];


    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'id_estatus');
    }
}
