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
        Schema::create('administrativo.clasificacion_componentes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_clasificacion')->constrained('administrativo.clasificacion_proyectos');
            $table->foreignId('id_componente_proyecto')->constrained('administrativo.componentes_proyectos');
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
        Schema::dropIfExists('administrativo.clasificacion_componentes');
    }
};
