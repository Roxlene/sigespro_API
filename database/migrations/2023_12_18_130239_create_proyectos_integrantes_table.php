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
        Schema::create('proyectos.integrantes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('equipo_id')->constrained('proyectos.equipos');
            $table->foreignId('user_id')->constrained('seguridad.usuarios');
            $table->boolean('scrum_master')->default(false);
            $table->foreignId('id_estatus')->constrained('administrativo.estatus');
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
        Schema::dropIfExists('proyectos.integrantes');
    }
};
