<?php

namespace App\Models\Administracion;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Direccion extends Model
{
    use HasFactory;

    public $table = "administrativo.direccion";

    protected $fillable = [
        'id_estado',
        'id_municipio',
        'id_parroquia',
        'detalles',
    ];


    public function estado()
    {
        return $this->belongsTo(Estados::class, 'id_estado')->select('id', 'nombre_estado');
    }

    public function municipio()
    {
        return $this->belongsTo(Municipios::class, 'id_municipio')->select('id', 'nombre_municipio');
    }

    public function parroquia()
    {
        return $this->belongsTo(Parroquia::class, 'id_parroquia')->select('id', 'nombre_parroquia');
    }
}
