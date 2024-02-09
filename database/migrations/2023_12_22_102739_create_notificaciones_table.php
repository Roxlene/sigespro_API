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
        Schema::create('proyectos.notificaciones', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
            $table->foreignId('user_id')->constrained('seguridad.usuarios');
            $table->foreignId('equipo_id')->constrained('proyectos.equipos');
            $table->boolean('leido')->default(false);
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
        Schema::dropIfExists('proyectos.notificaciones');
    }
};
