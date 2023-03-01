<?php

namespace Modules\Client\Http\Controllers\Api\v1;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Client\Entities\Group;

class GroupController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index()
    {
        $groups = Group::all();
        return response()->json($groups);
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('client::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        //
        // return $request->all();
        $validator = Validator::make($request->all(), [
            'group_name' => 'required',
            'venue' => 'required',
            'branch_id' => 'required',
            'order_of_the_day' => 'required'
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false,"errors" => $validator->errors()], 400);
        } else {
            $group = new Group();
            $group->group_name = $request->group_name;
            $group->branch_id = $request->branch_id;
            $group->venue = $request->venue;
            $group->order_of_the_day = $request->order_of_the_day;
            $group->day_of_the_week = $request->day_of_the_week;
            $group->meeting_frequency = $request->meeting_frequency;
            $group->save();
            custom_fields_save_form('add_group', $request, $group->id);
            return response()->json(['data' => $group, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('client::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('client::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        //
    }
}
