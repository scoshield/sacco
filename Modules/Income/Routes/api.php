<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/income', function (Request $request) {
    return $request->user();
});

Route::prefix('v1/incomes')->group(function () {
    Route::get('types', 'Api\v1\IncomeController@types');
    Route::apiResource('income', 'Api\v1\IncomeController');
});