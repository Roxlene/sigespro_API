<?php

namespace App\Models\Seguridad;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VistasSolicitudes extends Model
{
    use HasFactory;

    public $table = "seguridad.vistas_solicitudes";

    protected $fillable = [
        'user_id',
        'cant_soli',
        'soli_vistas',
        'soli_new'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
