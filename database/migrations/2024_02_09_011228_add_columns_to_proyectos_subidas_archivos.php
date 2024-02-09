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
        Schema::table('proyectos.subida_archivos', function (Blueprint $table) {
            $table->bigInteger('edicion_trabajo')->default(0);
            $table->bigInteger('edicion_laminas')->default(0);
            $table->bigInteger('edicion_producto')->default(0);
            $table->bigInteger('edicion_portafolio')->default(0);
            $table->bigInteger('correccion_trabajo')->default(0);
            $table->bigInteger('correccion_laminas')->default(0);
            $table->bigInteger('correccion_producto')->default(0);
            $table->bigInteger('correccion_portafolio')->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('proyectos.subida_archivos', function (Blueprint $table) {
            $table->dropColumn('edicion_trabajo');
            $table->dropColumn('edicion_laminas');
            $table->dropColumn('edicion_producto');
            $table->dropColumn('edicion_portafolio');
            $table->dropColumn('correccion_trabajo');
            $table->dropColumn('correccion_laminas');
            $table->dropColumn('correccion_producto');
            $table->dropColumn('correccion_portafolio');
        });
    }
};
