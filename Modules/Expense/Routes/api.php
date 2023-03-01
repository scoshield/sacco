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

Route::middleware('auth:api')->get('/expense', function (Request $request) {
    return $request->user();
});

Route::prefix('v1/expenses')->group(function() {
    Route::get('/', 'Api\v1\ExpenseController@index');
    Route::get('types', 'Api\v1\ExpenseController@types');
    Route::post('store', 'Api\v1\ExpenseController@store');
    // Route::apiResource('expense', 'Api\v1\ExpenseController');
});