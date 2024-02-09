<?php

namespace App\Models\Seguridad;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Auditoria extends Model
{
    use HasFactory;

    public $table = "seguridad.auditoria";

    protected $fillable = [
        'actividad',
        'direccion_ip',
        'accion',
        'id_usuario'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id_usuario');
    }

    public static function creacion($actividad, $accion)
    {
        return static::create([
            'actividad' => $actividad,
            'accion' => $accion,
            'id_usuario' => auth()->user()->id
        ]);
    }

    public static function creacion_terceros($actividad, $accion, $user)
    {
        return static::create([
            'actividad' => $actividad,
            'accion' => $accion,
            'id_usuario' => $user
        ]);
    }
}
