<?php

namespace Modules\Income\Http\Controllers\Api\v1;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Modules\Income\Entities\Income;
use Modules\Income\Entities\IncomeType;
use Modules\User\Entities\Register;
use Illuminate\Support\Facades\Auth;

class IncomeController extends Controller
{
     public function __construct()
    {
        $this->middleware('auth:api');
    }

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        //
        $incomes = IncomeType::all();
        return response()->json($incomes);
    }

    public function types()
    {
        $types = IncomeType::all();
        return response()->json($types);
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        //
        $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;
        // group id
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        //
    }
}
