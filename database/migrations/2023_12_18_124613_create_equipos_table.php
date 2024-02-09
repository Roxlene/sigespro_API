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
        Schema::create('proyectos.equipos', function (Blueprint $table) {
            $table->id();
            $table->integer('trayecto');
            $table->string('carrera');
            $table->string('seccion');
            $table->foreignId('proyecto_id')->nullable()->constrained('proyectos.proyectos');
            $table->foreignId('id_estatus')->constrained('administrativo.estatus');
            $table->foreignId('user_id')->constrained('seguridad.usuarios');
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
        Schema::dropIfExists('proyectos.equipos');
    }
};
