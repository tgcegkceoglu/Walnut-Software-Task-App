<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class AppointmentController extends Controller
{

    // Get Slots
    public function getSlots(Request $request)
    {
        try {
            $token = $request->bearerToken();

            if (!$token) {
                return response()->json([
                    'success' => false,
                    'message' => 'Token yok.',
                ], 401);
            }

            $response = Http::withToken($token)
                ->get(strapi_url('time-slots'));

            if ($response->successful()) {
                return response()->json([
                    'success' => true,
                    'data' => $response['data'] ?? [],
                ]);
            }

            return response()->json([
                'success' => false,
                'message' => 'Strapi hatası.',
                'error' => $response->json(),
            ], $response->status());
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Sunucu hatası.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function createAppointment(Request $request)
    {

        $jwtToken = $request->header('Authorization');
        $jwtToken = str_replace('Bearer ', '', $jwtToken);

        try {

            $request->validate([
                'userName' => 'nullable|string',
                'appointmentDate' => 'required|date',
                'age' => 'nullable|integer',
                'title' => 'nullable|string',
                'description' => 'nullable|string',
                'timeSlots' => 'required|array',
            ]);



            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $jwtToken,
            ])->post(strapi_url('appointments'), [


                'data' => [
                    'userName' => $request->userName,
                    'appointmentDate' => $request->appointmentDate,
                    'age' => $request->age,
                    'title' => $request->title,
                    'description' => $request->description,
                    'timeSlots' => $request->timeSlots,
                ]
            ]);

            if ($response->successful()) {
                $responseBody = $response->json();
                return response()->json([
                    'success' => true,
                    'message' => 'Create başarılı!',
                    'data' => $responseBody,
                ], 200)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Create başarısız',
                    'error' => $response->json()['error']['message'] ?? 'Bilinmeyen hata'
                ], $response->status())->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            }
        } catch (\Illuminate\Validation\ValidationException $ve) {
            return response()->json([
                'success' => false,
                'message' => 'Validation hatası',
                'errors' => $ve->errors(),
            ], 422)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Sunucu hatası',
                'error' => $e->getMessage()
            ], 500)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        }
    }

    public function getApppointment(Request $request)
    {

        $token = $request->bearerToken();

        if (!$token) {
            return response()->json([
                'success' => false,
                'error' => 'Token not found.',
            ], 401)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        }

        try {
            $response = Http::withToken($token)->get(strapi_url('appointments'));

            if ($response->successful()) {
                return response()->json([
                    'success' => true,
                    'data' => $response->json('data'),
                ], 200)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Appointments could not be made.',
                    'error' => $response->json('error.message') ?? 'unknown error',
                ], $response->status())->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Server error.',
                'error' => $e->getMessage(),
            ], 500)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        }
    }

    public function deleteAppointment(Request $request, $id)
    {
        $jwtToken = $request->header('Authorization');
        $jwtToken = str_replace('Bearer ', '', $jwtToken);

        try {

            $strapiDeleteUrl = strapi_url("appointments/$id");

            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $jwtToken,
            ])->delete($strapiDeleteUrl);

            if ($response->successful()) {
                return response()->json([
                    'success' => true,
                    'message' => 'Randevu başarıyla silindi.',
                ], 200)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Deletion failed',
                    'error' => $response->json()['error']['message'] ?? 'unkown',
                ], $response->status())->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'server error',
                'error' => $e->getMessage(),
            ], 500)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        }
    }

    public function updateAppointment(Request $request, $id)
    {


        $jwtToken = $request->header('Authorization');
        $jwtToken = str_replace('Bearer ', '', $jwtToken);

        try {
            $request->validate([
                'userName' => 'nullable|string',
                'appointmentDate' => 'required|date',
                'age' => 'nullable|integer',
                'title' => 'nullable|string',
                'description' => 'nullable|string',
                'timeSlots' => 'required|array',
            ]);
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $jwtToken,


            ])->put(strapi_url("appointments/{$id}"), [
                'data' => [
                    'userName' => $request->userName,
                    'appointmentDate' => $request->appointmentDate,
                    'age' => $request->age,
                    'title' => $request->title,
                    'description' => $request->description,
                    'timeSlots' => $request->timeSlots,
                ]
            ]);



            if ($response->successful()) {
                $responseBody = $response->json();
                return response()->json([
                    'success' => true,
                    'message' => 'Update successful!',
                    'data' => $responseBody,
                ], 200)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'Update failed!',
                    'error' => $response->json()['error']['message'] ?? 'unkown'
                ], $response->status())->setEncodingOptions(JSON_UNESCAPED_UNICODE);
            }
        } catch (\Illuminate\Validation\ValidationException $ve) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $ve->errors(),
            ], 422)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'server error',
                'error' => $e->getMessage()
            ], 500)->setEncodingOptions(JSON_UNESCAPED_UNICODE);
        }
    }
}
