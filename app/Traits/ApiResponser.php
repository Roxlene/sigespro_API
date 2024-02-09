<?php

namespace App\Traits;

use App\Transformers\UserTransformer;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use League\Fractal\Resource\Collection as FractalCollection;

trait ApiResponser
{
    public function success($data, $status, $message = null)
    {
        $response = ['status' => $status, 'content' => $data];

        if ($message) {
            $response['message'] = $message;
        }

        return response()->json($response, 200);
    }

    public function goReturn($data, $status, $message = null)
    {

        $response = ['status' => $status, 'content' => $data];

        if ($message) {
            $response['message'] = $message;
        }

        return response()->json($response, 200);
    }

    protected function error($message, $status)
    {
        return response()->json(['status' => $status, 'message' => $message, 'content' => null], $status);
    }

    protected function message($message, $status = 200)
    {
        return $this->success(null, $status, $message);
    }

    protected function showAll(Collection $collection, $status = 200, $message = null)
    {
        if ($collection->isEmpty()) {
            return $this->success($collection, $status);
        }

        if ($collection->first() instanceof Model && property_exists($collection->first(), 'transformer')) {
            $transformer = $collection->first()->transformer;
            $collection = $this->transform($collection, $transformer);
        }


        return $this->success($collection, $status, $message);
    }

    protected function showOne($instance, $status = 200, $message = null)
    {
        if ($instance instanceof Model && property_exists($instance, 'transformer')) {
            $transformer = $instance->transformer;
            $instance = $this->transform($instance, $transformer);
        }

        return $this->success($instance, $status, $message);
    }

    protected function showToken($token)
    {
        $user = Auth::user();

        //$user = new Collection($user, new UserTransformer());


        $user = $this->transform($user, $user->transformer);

        $session = [
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => Carbon::now()->addMinutes(config('jwt.ttl')),
            'user' => $user,
        ];

        return $this->success($session, 200);
    }

    protected function filter(Collection $collection)
    {
        foreach (request()->query() as $query => $value) {
            // $attribute = $transformer::originalAttribute($query);
            $attribute = $query;

            if (isset($attribute, $value)) {
                $collection = $collection->where($attribute, $value);
            }
        }
        return $collection;
    }

    protected function sort(Collection $collection)
    {
        if (request()->has('sortBy')) {
            // $attribute = $transformer::originalAttribute(request()->sortBy);
            $attribute = request()->sortBy;

            $collection = $collection->sortBy->{$attribute};
        }
        return $collection;
    }

    protected function paginate(Collection $collection)
    {
        request()->validate([
            'perPage' => 'integer|in:5,10,20,50,100'
        ]);

        $page = LengthAwarePaginator::resolveCurrentPage();

        $perPage = 10;
        if (request()->has('perPage')) {
            $perPage = (int) request()->perPage;
        }

        $pagination = $collection->slice(($page - 1) * $perPage, $perPage)->values();

        $paginated = new LengthAwarePaginator($pagination, $collection->count(), $perPage, $page, [
            'path' => LengthAwarePaginator::resolveCurrentPath(),
        ]);

        $paginated->appends(request()->all());

        return $paginated;
    }

    protected function transform($data, $transformer)
    {
        $transformation = fractal($data, new $transformer)->toArray();

        return $transformation['data'];
    }

    protected function cacheResponse($data)
    {
        $url = request()->url();

        $queryParams = request()->query();

        ksort($queryParams);

        $queryString = http_build_query($queryParams);

        $fullUrl = "{$url}?{$queryString}";

        return Cache::remember($fullUrl, 15 / 60, function () use ($data) {
            return $data;
        });
    }
}
