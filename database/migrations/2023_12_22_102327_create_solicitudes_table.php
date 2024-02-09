<?php

use App\Models\Administracion\Estatus;
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
        Schema::create('proyectos.solicitudes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('solicitante_id')->constrained('proyectos.integrantes');
            $table->foreignId('equipo_id')->constrained('proyectos.equipos');
            $table->foreignId('user_id')->nullable()->constrained('seguridad.usuarios');
            $table->foreignId('id_estatus')->default(Estatus::En_espera_respuesta)->constrained('administrativo.estatus');
            $table->boolean('integracion')->default(true);
            $table->foreignId('integrante_id_desincorporar')->nullable()->constrained('proyectos.integrantes');
            $table->string('motivo_desincorporacion')->nullable();
            $table->string('motivo_denegacion')->nullable();
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
        Schema::dropIfExists('proyectos.solicitudes');
    }
};
