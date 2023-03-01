<?php

namespace Modules\Events\Http\Controllers\Api\v1;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Events\Entities\Event;
use Illuminate\Support\Facades\Auth;
use Modules\User\Entities\User;
use Modules\Client\Entities\Group;
use Modules\Branch\Entities\Branch;
use Carbon\Carbon;
// use

class EventsController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index()
    {
        $events = Event::with('group')
                        // ->selectRaw('client_groups.group_name name, events.start, events.end')
                        ->get();
        return response()->json(['data' => $events]);
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('events::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        //
        $events = $request->all();

        // return $request->all();
        $input = Validator::make($request->all(), [
            'location' => ['required'],
            'start' => ['required','date','after:today'],
            'end' => ['required','date','after:start']
        ]);



        if ($input->fails()) {
            return response()->json($input->errors(), 422);
        }else{
            // commit the relationship
            // return $request;
            $event = Event::create([
                'name' => strtoupper(substr(md5(time()), 0, 6)),
                'start' => Carbon::parse($request->start)->addHours(3),
                'end' => Carbon::parse($request->end)->addHours(3),
                'notes'=> $request->notes,
                'location' => $request->location,
                'description'=>$request->notes,
                'user_id' => Auth::id(),
                'group_id'=>$request->group_id,
                'branch_id'=>Group::find($request->group_id)->branch_id,

            ]);

            return $event;

        }
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('events::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('events::edit');
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
