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
        Schema::create('administrativo.clasificacion_proyectos', function (Blueprint $table) {
            $table->id();
            $table->string('trayecto');
            $table->string('descripcion');
            $table->string('carrera');
            $table->foreignId('id_estatus')->default(1)->constrained('administrativo.estatus')->onUpdate('cascade');
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
        Schema::dropIfExists('administrativo.clasificacion_proyectos');
    }
};
