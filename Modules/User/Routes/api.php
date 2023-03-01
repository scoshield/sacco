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

Route::prefix('v1')->group(function () {

    Route::post('login', 'Api\v1\AuthController@login');
    Route::post('register', 'Api\v1\AuthController@register');
    Route::middleware('auth:api')->post('/logout', 'Api\v1\AuthController@logout');
    Route::prefix('user')->group(function () {
        Route::get('/', 'Api\v1\UserController@index');
        Route::get('/permissions', 'Api\v1\UserController');
        Route::get('/get_user', 'Api\v1\AuthController@get_user');
        Route::get('/logout', 'Api\v1\AuthController@logout');
        Route::get('/get_custom_fields', 'Api\v1\UserController@get_custom_fields');
        Route::get('create', 'Api\v1\UserController@create');
        Route::post('store', 'Api\v1\UserController@store');
        Route::get('{id}/show', 'Api\v1\UserController@show');
        Route::get('{id}/edit', 'Api\v1\UserController@edit');
        Route::post('{id}/update', 'Api\v1\UserController@update');
        Route::get('{id}/destroy', 'Api\v1\UserController@destroy');
        Route::get('edit_profile', 'Api\v1\UserController@edit_profile');
        Route::post('update_profile', 'Api\v1\UserController@update_profile');
        Route::get('registers/find_open_register', 'Api\v1\RegisterController@find_open_register');
        Route::get('registers/group_register_expense/{id}', 'Api\v1\RegisterController@group_register_expenses');
        Route::apiResource('registers', 'Api\v1\RegisterController');
        Route::post('registers/{id}/approval', 'Api\v1\RegisterController@register_approval');
        Route::post('registers/{id}/close', 'Api\v1\RegisterController@close_register');
        Route::post('registers/{id}/reopen', 'Api\v1\RegisterController@reopen_register');
        Route::get('register/{id}/group/{rid}', 'Api\v1\RegisterController@group_register_summary');
        // Route::get('register/{id}/data/{group_id}', 'Api\v1\RegisterController@detailed_group_register');
        Route::get('register/{id}/groups/{group_id}', 'Api\v1\RegisterController@detailed_group_register');
        Route::post('register/{id}/initiate_transfer', 'Api\v1\RegisterController@initiate_transfer');
        Route::get('register/{reg}/group/{id}/type/{type}/savings_transactions', 'Api\v1\RegisterController@get_transactions');
        Route::get('register/{reg}/group/{id}/method/{type}/transactions', 'Api\v1\RegisterController@get_cash_transactions');
        Route::get('register/{reg}/group/{id}/product/{product}/type/{type}/transactions', 'Api\v1\RegisterController@get_loans_transactions');
        //
        Route::prefix('role')->group(function () {
            Route::get('/', 'Api\v1\RoleController@index');
            Route::get('get_permissions', 'Api\v1\RoleController@get_permissions');
            Route::get('create', 'Api\v1\RoleController@create');
            Route::post('store', 'Api\v1\RoleController@store');
            Route::get('{id}/show', 'Api\v1\RoleController@show');
            Route::get('{id}/edit', 'Api\v1\RoleController@edit');
            Route::post('{id}/update', 'Api\v1\RoleController@update');
            Route::get('{id}/destroy', 'Api\v1\RoleController@destroy');
        });
    });
});