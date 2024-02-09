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
        Schema::create('proyectos.avances_equipos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('equipo_id')->constrained('proyectos.equipos');
            $table->foreignId('item_evaluado_id')->constrained('administrativo.items_evaluados');
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
        Schema::dropIfExists('proyectos.avances_equipos');
    }
};
