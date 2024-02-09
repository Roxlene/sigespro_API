<?php

namespace App\Http\Middleware;

use App\Transformers\UserTransformer;
use Closure;
use Illuminate\Http\Request;

class ValidacionEstudiante
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        if (UserTransformer::transform(auth()->user())['userType'] != "ESTUDIANTE") {
            return response()->json(['status' => 400, 'message' => 'No tiene permiso para realizar esta acción. Debe ser estudiante para ejecutarla.'], 400);
        }
        return $next($request);
    }
}
