<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;


return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement('CREATE SCHEMA "administrativo"');
        DB::statement('CREATE SCHEMA "entidades"');
        DB::statement('CREATE SCHEMA "proyectos"');
        DB::statement('CREATE SCHEMA "seguridad"');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement('DROP SCHEMA "administrativo" CASCADE');
        DB::statement('DROP SCHEMA "entidades" CASCADE');
        DB::statement('DROP SCHEMA "proyectos" CASCADE');
        DB::statement('DROP SCHEMA "seguridad" CASCADE');
    }
};
