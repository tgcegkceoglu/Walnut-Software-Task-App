<?php

if (!function_exists('strapi_url')) {
    function strapi_url($path = '')
    {
        $baseUrl = env('STRAPI_API_URL');
        return rtrim($baseUrl, '/') . '/' . ltrim($path, '/');
    }
}
