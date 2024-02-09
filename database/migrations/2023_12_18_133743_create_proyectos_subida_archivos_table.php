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
        Schema::create('proyectos.subida_archivos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('proyecto_id')->nullable()->constrained('proyectos.proyectos');
            $table->foreignId('equipo_id')->constrained('proyectos.equipos');
            $table->foreignId('actividad_id')->constrained('proyectos.actividades_equipos');
            $table->string('investigacion')->nullable();
            $table->string('presentacion')->nullable();
            $table->string('producto')->nullable();
            $table->string('portafolio')->nullable();
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
        Schema::dropIfExists('proyectos.subida_archivos');
    }
};
