<?php

namespace App\Models\Proyectos;

use App\Transformers\UserTransformer;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Postulaciones extends Model
{
    use HasFactory;

    public $table = "proyectos.postulaciones";

    protected $fillable = [
        'equipo_id',
        'proyecto_id',
        'id_estatus',
    ];

    public function equipo()
    {
        return $this->belongsTo(Equipos::class, 'equipo_id');
    }

    public static function crear_postulacion($proyecto_id)
    {
        $transform = UserTransformer::transform(auth()->user());
        return static::create([
            'equipo_id' => $transform['integrante_equipo']['equipo_id'],
            'proyecto_id' => $proyecto_id,
        ]);
    }
}
