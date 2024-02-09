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
        Schema::create('administrativo.parroquia', function (Blueprint $table) {
            $table->id();
            $table->string('codigo_parroquia');
            $table->string('nombre_parroquia');
            $table->foreignId('id_municipio')->constrained('administrativo.municipio')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('administrativo.parroquia');
    }
};
