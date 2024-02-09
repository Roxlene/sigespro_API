<?php

namespace App\Models\Administracion;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClasificacionProyectos extends Model
{
    use HasFactory;

    public $table = "administrativo.clasificacion_proyectos";

    protected $fillable = [
        'trayecto',
        'descripcion',
        'carrera',
        'id_estatus',
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
