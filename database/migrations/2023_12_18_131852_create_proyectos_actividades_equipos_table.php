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
        Schema::create('proyectos.actividades_equipos', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->foreignId('equipo_id')->constrained('proyectos.equipos');
            $table->foreignId('user_id')->constrained('seguridad.usuarios');
            $table->string('producto');
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
        Schema::dropIfExists('proyectos.actividades_equipos');
    }
};
