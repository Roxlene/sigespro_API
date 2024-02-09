<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Models\Seguridad\Configuraciones;
use App\Transformers\UserTransformer;
use Carbon\Carbon;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Laravel\Sanctum\HasApiTokens;

class AuthenticatedSessionController extends Controller
{
    use HasApiTokens;
    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required'],
        ]);



        if (!$token = auth()->attempt($credentials)) {
            return $this->error('Usuario o contraseña incorrecta', 401);
        }

        $user =  UserTransformer::transform(auth()->user());


        return $this->respondWithToken($token, $user);
    }

    /**
     * Destroy an authenticated session.
     */
    public function destroy(Request $request): Response
    {
        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return response()->noContent();
    }

    protected function respondWithToken($token, $user)
    {
        return response()->json([
            'status' => 200,
            'content' => [
                'access_token' => $token,
                'token_type' => 'bearer',
                'expires_in' =>  Carbon::now()->addMinutes(env('JWT_TTL'))->format('d-m-Y,H:m:s'),
                'user' => $user,
                'configuracion' => Configuraciones::all()
            ]

        ]);
    }


    public function me()
    {

        (auth()->user()) ?
            $user =  UserTransformer::transform(auth()->user())
            : $user = null;

        return $this->success($user, 200, 'datos encontrados');
    }
}
