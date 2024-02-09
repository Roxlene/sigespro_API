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
        Schema::create('administrativo.items_evaluados', function (Blueprint $table) {
            $table->id();
            $table->foreignId('item_id')->constrained('administrativo.items')->onUpdate('cascade');
            $table->string('porcentaje');
            $table->foreignId('clasificacion_id')->constrained('administrativo.clasificacion_proyectos')->onUpdate('cascade');
            $table->foreignId('id_estatus')->default(1)->constrained('administrativo.estatus')->onUpdate('cascade');
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
        Schema::dropIfExists('administrativo.items_evaluados');
    }
};
