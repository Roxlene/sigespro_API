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
        Schema::create('seguridad.usuarios', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_persona')->constrained('entidades.persona')->onUpdate('cascade')->onDelete('cascade');
            $table->foreignId('id_tipo_usuario')->constrained('administrativo.tipo_usuario')->onUpdate('cascade');
            $table->string('email');
            $table->string('password');
            $table->timestamp('email_verified_at')->nullable();
            $table->timestamp('phone_verified_at')->nullable();
            $table->timestamp('password_changed')->nullable();
            $table->foreignId('id_comunidad')->nullable()->constrained('entidades.comunidad')->onUpdate('cascade')->onDelete('cascade');
            $table->foreignId('id_estatus')->default(1)->constrained('administrativo.estatus')->onUpdate('cascade');
            $table->string('foto_url')->nullable();
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
        Schema::dropIfExists('seguridad.usuarios');
    }
};
