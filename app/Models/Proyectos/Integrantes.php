<?php

namespace App\Models\Proyectos;

use App\Models\Administracion\Estatus;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Integrantes extends Model
{
    use HasFactory;

    public $table = "proyectos.integrantes";

    protected $fillable = [
        'equipo_id',
        'scrum_master',
        'id_estatus',
        'user_id'
    ];

    public function usuario()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public static function estatus_equipo()
    {
        return static::select('integrantes.*', 'equipos.*', 'integrantes.id as integrante_id', 'estatus.descripcion')
            ->join('proyectos.equipos', 'equipos.id', 'integrantes.equipo_id')
            ->join('administrativo.estatus', 'estatus.id', 'equipos.id_estatus')
            ->where('integrantes.user_id', auth()->user()->id)
            ->whereIn('equipos.id_estatus', array(Estatus::Activo, Estatus::Aperturado, Estatus::En_desarrollo))
            ->where('integrantes.id_estatus', Estatus::Activo)
            ->first();
    }

    public static function estatus_user_equipo()
    {
        return !is_null(static::estatus_equipo());
    }

    public static function estatus_scrum_master()
    {
        return static::estatus_equipo()->scrum_master;
    }
}
