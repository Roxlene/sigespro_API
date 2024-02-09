<?php

namespace App\Models\Administracion;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Estatus extends Model
{
    use HasFactory;

    public $table = "administrativo.estatus";

    //General
    const Activo = 1;
    const Inactivo = 2;

    //Necesidades
    const Denegado = 3;
    const Espera_verificacion = 4;
    const Aprobado = 5;

    //Proyecto
    const En_desarrollo = 6;
    const Finalizado = 7;
    const En_espera_asignacion = 8;

    //Equipos
    const Aperturado = 9;
    const Retirado = 10;

    //Solicitudes de equipos
    const En_espera_respuesta = 11;
    const Solicitud_rechazada = 12;
    const Solicitud_aceptada = 13;


    protected $fillable = [
        'descripcion',
        'categoria',
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
    ];
}
