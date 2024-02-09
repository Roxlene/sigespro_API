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
        Schema::create('seguridad.vistas_notificaciones', function (Blueprint $table) {
            $table->id();
            $table->integer('cant_not');
            $table->integer('not_vistas');
            $table->integer('not_new');
            $table->foreignId('user_id')->nullable()->constrained('seguridad.usuarios');
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
        Schema::dropIfExists('seguridad.vistas_notificaciones');
    }
};
