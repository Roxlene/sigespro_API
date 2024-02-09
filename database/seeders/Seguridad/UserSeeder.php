<?php

namespace Database\Seeders\Seguridad;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'id_persona' => 1,
            'id_tipo_usuario' => 2,
            'email' => 'admin@admin.com',
            'password' => Hash::make('Desarrollo123'),
            'id_comunidad' => 1,
            'id_estatus' => 1,
        ])->assignRole('administrador');
    }
}
