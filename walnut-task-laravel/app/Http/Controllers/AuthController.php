<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {

            $request->validate([
                'username' => 'required|string',
                'email' => 'required|string',
                'password' => 'required|string',
            ]);

            $response = Http::post(strapi_url('auth/local/register'), [
                'username' => $request->username,
                'email' => $request->email,
                'password' => $request->password,
            ]);

            if ($response->successful()) {
                return response()->json([
                    'success' => true,
                    'message' => 'Registration successful!',
                    'data' => $response->json()
                ], 200)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Registration failed!',
                    'error' => $response->json()['error']['message'] ?? 'unkown'
                ], 400)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Server error',
                'error' => $e->getMessage()
            ], 500)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        }
    }

    public function login(Request $request)
    {

        try {

            $request->validate([
                'identifier' => 'required|string',
                'password' => 'required|string',
            ]);

            $response = Http::post(strapi_url('auth/local'), [
                'identifier' => $request->identifier,
                'password' => $request->password,
            ]);

            if ($response->successful()) {
                $responseBody = $response->json();
                return response()->json([
                    'success' => true,
                    'message' => 'Registration successful!',
                    'data' => $responseBody,
                ], 200)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Registration failed!',
                    'error' => $response->json()['error']['message'] ?? 'unkown'
                ], 401)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'server error',
                'error' => $e->getMessage()
            ], 500)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        }
    }

}
