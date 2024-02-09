<?php

namespace App\Models\Entidades;

use App\Models\Administracion\Direccion;
use App\Models\Administracion\Estatus;
use App\Models\Administracion\Motivos_denegacion;
use App\Models\Seguridad\Auditoria;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Necesidades extends Model
{
    use HasFactory;

    public $table = "proyectos.necesidades";

    protected $fillable = [
        'user_id',
        'necesidad',
        'cod_necesidad',
        'id_estatus',
        'direccion_id',
        'evaluado_por',
        'id_motivo',
        'fecha_verificacion',
    ];

    protected $casts = [
        'created_at'  => 'date:d-m-Y',
        'updated_at' => 'date:d-m-Y',
        'fecha_verificacion' => 'date:d-m-Y',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function evaluado_por()
    {
        return $this->belongsTo(User::class, 'evaluado_por');
    }

    public function estatus()
    {
        return $this->belongsTo(Estatus::class, 'id_estatus')->select('id', 'descripcion');
    }

    public function motivo()
    {
        return $this->belongsTo(Motivos_denegacion::class, 'id_motivo')->select('id', 'descripcion');
    }

    public function direccion()
    {
        return $this->belongsTo(Direccion::class, 'direccion_id');
    }

    public static function necesidades_en_espera($paginate = null, $search, $status)
    {
        if ($status) {
            return static::with('user.persona', 'user.comunidad', 'direccion', 'direccion.estado', 'direccion.municipio', 'direccion.parroquia', 'estatus')->where('necesidad', 'like', '%' . $search . '%')->whereId_estatus($status)->where('id_estatus', '<>', 2)->orderBy('created_at', 'desc')->paginate($paginate);
        } else {
            return static::with('user.persona', 'user.comunidad', 'direccion', 'direccion.estado', 'direccion.municipio', 'direccion.parroquia', 'estatus')->where('necesidad', 'like', '%' . $search . '%')->where('id_estatus', '<>', Estatus::Inactivo)->orderBy('created_at', 'desc')->paginate($paginate);
        }
    }

    public static function necesidades_denegadas()
    {
        return static::with('user.persona', 'estatus', 'motivo')->whereId_estatus(Estatus::Denegado)->first();
    }

    public static function necesidades_por_usuario($id_usuario, $paginate, $search)
    {
        return static::with('evaluado_por.persona', 'estatus', 'direccion.estado', 'direccion.municipio', 'direccion.parroquia', 'motivo')->where('necesidad', 'like', '%' . $search . '%')->whereUser_id($id_usuario)->orderBy('id', 'asc')->paginate($paginate);
    }

    public static function create_necesidad($request)
    {
        $cod = now()->format('d') . auth()->user()->id . now()->format('Hms');

        $direccion = Direccion::firstOrCreate(
            [
                "id_estado" => $request['estado_id'],
                "id_municipio" => $request['municipio_id'],
                "id_parroquia" => $request['parroquia_id'],
                "detalles" => $request['direccion']
            ]

        );

        $necesidad = static::create([
            'user_id' => auth()->user()->id,
            'necesidad' => $request['necesidad'],
            'cod_necesidad' => $cod,
            'direccion_id' => $direccion->id,
        ]);

        Auditoria::creacion(
            'Registro de necesidad: ' . $necesidad->cod_necesidad,
            'INSERT proyectos.necesidades',
        );

        return $necesidad;
    }

    public static function update_necesidad($request, $necesidad)
    {

        if ($necesidad->direccion->id == auth()->user()->comunidad->direccion->id) {
            $direccion = Direccion::firstOrCreate(
                [
                    "id_estado" => $request['estado_id'],
                    "id_municipio" => $request['municipio_id'],
                    "id_parroquia" => $request['parroquia_id'],
                    "detalles" => $request['direccion']
                ]

            );
        } else {
            $direccion = Direccion::updateOrCreate(
                ['id' =>  $necesidad->direccion->id],
                [
                    "id_estado" => $request['estado_id'],
                    "id_municipio" => $request['municipio_id'],
                    "id_parroquia" => $request['parroquia_id'],
                    "detalles" => $request['direccion']
                ]

            );
        }


        $necesidad->update([
            'necesidad' => $request['necesidad'],
            'direccion_id' => $direccion->id,
        ]);

        Auditoria::creacion(
            'Actualización de necesidad: ' . $necesidad->cod_necesidad,
            'UPDATE proyectos.necesidades',
        );

        $data = [
            'necesidad' => $necesidad,
            'direccion' => $direccion
        ];

        return $data;
    }

    public static function cambio_status($necesidad, $estatus)
    {
        $necesidad->fill(['id_estatus' => $estatus, 'user_id' => auth()->user()->id])->saveOrfail();
        Auditoria::creacion(
            'Cambio de estatus de la necesidad: ' . $necesidad->cod_necesidad,
            'UPDATE proyectos.necesidades',
        );
        return $necesidad;
    }

    public static function denegacion_necesidad($necesidad, $motivo_id)
    {
        $necesidad->fill(['id_estatus' => Estatus::Denegado, 'id_motivo' => $motivo_id])->saveOrfail();
        Auditoria::creacion(
            'Denegó la necesidad: ' . $necesidad->cod_necesidad,
            'UPDATE proyectos.necesidades',
        );
        return $necesidad;
    }
}
