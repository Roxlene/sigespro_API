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
        Schema::table('proyectos.actividades_equipos', function (Blueprint $table) {
            $table->bigInteger('cod_actividad');
            $table->foreignId('actividad_padre')->nullable()->constrained('proyectos.actividades_equipos');
            $table->foreignId('proyecto_id')->nullable()->constrained('proyectos.proyectos');
            $table->foreignId('estatus_id')->default(Estatus::Activo)->constrained('administrativo.estatus');;
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('proyectos.actividades_equipos', function (Blueprint $table) {
            $table->dropColumn('cod_actividad');
            $table->dropColumn('actividad_padre');
            $table->dropColumn('proyecto_id');
            $table->dropColumn('estatus_id');
        });
    }
};
