<?php

namespace App\Models\Seguridad;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VistasNotificaciones extends Model
{
    use HasFactory;

    public $table = "seguridad.vistas_notificaciones";

    protected $fillable = [
        'user_id',
        'cant_not',
        'not_vistas',
        'not_new'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
