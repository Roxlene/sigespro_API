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
        Schema::create('administrativo.items', function (Blueprint $table) {
            $table->id();
            $table->string('descripcion');
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
        Schema::dropIfExists('administrativo.items');
    }
};
