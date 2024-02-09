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
        Schema::create('administrativo.direccion', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_estado')->constrained('administrativo.estado')->onUpdate('cascade');
            $table->foreignId('id_municipio')->constrained('administrativo.municipio')->onUpdate('cascade');
            $table->foreignId('id_parroquia')->constrained('administrativo.parroquia')->onUpdate('cascade');
            $table->string('detalles')->nullable();
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
        Schema::dropIfExists('administrativo.direccion');
    }
};
