<?php

namespace App\Models\Proyectos;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ActividadesEquipos extends Model
{
    use HasFactory;

    public $table = 'proyectos.actividades_equipos';

    protected $fillable = [
        'descripcion',
        'proyecto_id',
        'equipo_id',
        'user_id',
        'producto',
        'cod_actividad',
        'actividad_padre'
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];

    public function usuario()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function respuestas()
    {
        return $this->hasMany(static::class, 'actividad_padre');
    }

    public static function create_actividad($descripcion, $equipo, $proyecto = null, $padre = null)
    {
        $codigo = $equipo . date('dmYHmm');
        return static::create([
            'cod_actividad'  => $codigo,
            'descripcion'  => $descripcion,
            'equipo_id' => $equipo,
            'proyecto_id' => $proyecto,
            'user_id' => auth()->user()->id,
            'actividad_padre' => $padre
        ]);
    }
}
