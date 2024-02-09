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
        Schema::create('proyectos.proyecto_clasificado', function (Blueprint $table) {
            $table->id();
            $table->foreignId('proyectos_id')->constrained('proyectos.proyectos')->onUpdate('cascade')->onDelete('cascade');
            $table->foreignId('clasificacion_id')->constrained('administrativo.clasificacion_proyectos')->onUpdate('cascade')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('proyectos.proyecto_clasificado');
    }
};
