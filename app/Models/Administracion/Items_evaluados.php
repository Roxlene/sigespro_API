<?php

namespace App\Models\Administracion;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Items_evaluados extends Model
{
    use HasFactory;

    public $table = "administrativo.items_evaluados";

    protected $fillable = [
        'item_id',
        'porcentaje',
        'clasificacion_id',
        'id_estatus',
        'user_id'
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];

    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'id_estatus');
    }

    public function clasificacion()
    {
        return $this->belongsTo(ClasificacionProyectos::class, 'clasificacion_id');
    }

    public function item()
    {
        return $this->belongsTo(Items::class, 'item_id')->select('id', 'descripcion');
    }
}
