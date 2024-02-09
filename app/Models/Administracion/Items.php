<?php

namespace App\Models\Administracion;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Items extends Model
{
    use HasFactory;

    public $table = "administrativo.items";

    protected $fillable = [
        'descripcion',
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

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function items_evaluados()
    {
        return $this->hasOne(Item::class, 'item_id');
    }
}
