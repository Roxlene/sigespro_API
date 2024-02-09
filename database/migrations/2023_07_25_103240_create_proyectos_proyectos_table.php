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
        Schema::create('proyectos.proyectos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('necesidad_id')->constrained('proyectos.necesidades')->onUpdate('cascade')->onDelete('cascade');
            $table->string('especificacion')->nullable();
            $table->foreignId('id_estatus')->default(8)->constrained('administrativo.estatus')->onUpdate('cascade');
            $table->foreignId('user_id')->nullable()->constrained('seguridad.usuarios')->onUpdate('cascade');
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
        Schema::dropIfExists('proyectos.proyectos');
    }
};
