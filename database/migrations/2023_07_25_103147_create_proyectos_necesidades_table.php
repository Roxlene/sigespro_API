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
        Schema::create('proyectos.necesidades', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('seguridad.usuarios')->onUpdate('cascade');
            $table->string('necesidad');
            $table->string('cod_necesidad');
            $table->foreignId('id_estatus')->default(4)->constrained('administrativo.estatus')->onUpdate('cascade');
            $table->foreignId('id_motivo')->constrained('administrativo.motivo_denegacion')->onUpdate('cascade');
            $table->foreignId('direccion_id')->constrained('administrativo.direccion')->onUpdate('cascade');
            $table->foreignId('evaluado_por')->constrained('seguridad.usuarios')->onUpdate('cascade');
            $table->timestamp('fecha_verificacion')->nullable();
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
        Schema::dropIfExists('proyectos.necesidades');
    }
};
