<?php

namespace App\Models\proyectos;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class notificaciones extends Model
{
    use HasFactory;

    public $table = "proyectos.notificaciones";

    protected $fillable = [
        'descripcion',
        'leido',
        'equipo_id',
        'user_id'
    ];

    public static function create_notificacion($descripcion, $equipo = null,)
    {
        return static::create([
            'descripcion'  => $descripcion,
            'equipo_id' => $equipo,
            'user_id' => auth()->user()->id
        ]);
    }

    public static function create_notificacion_terceros($descripcion, $user = null,)
    {
        if ($user) {
            return static::create([
                'descripcion'  => $descripcion,
                'user_id' => $user
            ]);
        } else {
            return static::create([
                'descripcion'  => $descripcion,
                'user_id' => auth()->user()->id
            ]);
        }
    }
}
