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
        Schema::create('seguridad.auditoria', function (Blueprint $table) {
            $table->id();
            $table->string('actividad');
            $table->string('direccion_ip');
            $table->foreignId('id_usuario')->constrained('seguridad.usuarios')->onUpdate('cascade');
            $table->string('accion');
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
        Schema::dropIfExists('seguridad.auditoria');
    }
};
