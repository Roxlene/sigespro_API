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
        Schema::create('administrativo.municipio', function (Blueprint $table) {
            $table->id();
            $table->string('codigo_municipio');
            $table->string('nombre_municipio');
            $table->foreignId('id_estado')->constrained('administrativo.estado')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('administrativo.municipio');
    }
};
