<?php

namespace App\Http\Middleware;

use App\Transformers\UserTransformer;
use Closure;
use Illuminate\Http\Request;

class ValidacionScrumMaster
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
        if (UserTransformer::transform(auth()->user())['scrum_master'] == false) {
            return response()->json(['status' => 400, 'message' => 'No tiene permiso para realizar una solicitud. Solo el Scrum Master o lider de proyecto puede hacerlo.'], 400);
        }
        return $next($request);
    }
}
