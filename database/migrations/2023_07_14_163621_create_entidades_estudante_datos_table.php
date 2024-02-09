<?php

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
        Schema::create('entidades.usuario_datos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_usuario')->constrained('seguridad.usuarios')->onUpdate('cascade');
            $table->string('cod_carrera');
            $table->string('seccion');
            $table->integer('trayecto');
            $table->foreignId('estatus_id')->constrained('administrativo.estatus')->onUpdate('cascade');
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
        Schema::dropIfExists('entidades.usuario_datos');
    }
};
