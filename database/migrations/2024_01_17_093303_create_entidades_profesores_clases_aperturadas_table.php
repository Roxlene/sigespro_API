<?php

use App\Models\Administracion\Estatus;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('entidades.profesores_clases_aperturadas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('seguridad.usuarios');
            $table->foreignId('clase_aperturada_id')->nullable()->constrained('entidades.aperturas');
            $table->string('tipo_asesor');
            $table->foreignId('id_estatus')->default(Estatus::Activo)->constrained('administrativo.estatus');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('entidades.profesores_clases_aperturadas');
    }
};
