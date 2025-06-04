<?php

use App\Http\Controllers\AppointmentController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;


// Auth Route
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/slots', [AppointmentController::class, 'getSlots']);
Route::post('/createApppointment', [AppointmentController::class, 'createAppointment']);
Route::post('/updateApppointment/{id}', [AppointmentController::class, 'updateApppointment']);
Route::get('/getApppointment', [AppointmentController::class, 'getApppointment']);
Route::delete('/deleteAppointment/{id}', [AppointmentController::class, 'deleteAppointment']);
Route::put('/updateAppointment/{id}', [AppointmentController::class, 'updateAppointment']);

