<?php

namespace Modules\Client\Http\Controllers;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Laracasts\Flash\Flash;
use Modules\Client\Entities\ClientType;
use Modules\Client\Entities\Group;
use Yajra\DataTables\Facades\DataTables;
use PDF;

class GroupController extends Controller
{

    public function __construct()
    {
        $this->middleware(['auth', '2fa']);
        $this->middleware(['permission:client.clients.groups.index'])->only(['index', 'show']);
        $this->middleware(['permission:client.clients.groups.create'])->only(['create', 'store']);
        $this->middleware(['permission:client.clients.groups.edit'])->only(['edit', 'update']);
        $this->middleware(['permission:client.clients.groups.destroy'])->only(['destroy']);

    }
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index(Request $request)
    {
        $perPage = $request->per_page ?: 20;
        $orderBy = $request->order_by;
        $orderByDir = $request->order_by_dir;
        $search = $request->s;
        $data = Group::when($orderBy, function (Builder $query) use ($orderBy, $orderByDir) {
            $query->orderBy($orderBy, $orderByDir);
        })
            ->when($search, function (Builder $query) use ($search) {
                $query->where('group_name', 'like', "%$search%");
            })
            ->paginate($perPage)
            ->appends($request->input());
        return theme_view('client::group.index',compact('data'));
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return theme_view('client::group.create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        $request->validate([
            'group_name' => ['required'],
        ]);
        $group = new Group();
        $group->group_name = $request->group_name;
        $group->venue = $request->venue;
        $group->order_of_the_day = $request->order_of_the_day;
        $group->day_of_the_week = $request->day_of_the_week;
        $group->meeting_frequency = $request->meeting_frequency;
        $group->save();
        activity()->on($group)
            ->withProperties(['id' => $group->id])
            ->log('Create Client Group');
        \flash(trans_choice("core::general.successfully_saved", 1))->success()->important();
        return redirect('client/group');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show(Request $request, $id)
    {
        $group = Group::find($id);

         //check if we should download
         if ($request->download) {
            if ($request->type == 'pdf') {
                $pdf = PDF::loadView(theme_view_file('client::group.download'), compact('group'));
                return $pdf->download('Group Report' . '.pdf');
            }           
        }

        return theme_view('client::group.show', compact('group'));
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        $group = Group::find($id);
        return theme_view('client::group.edit', compact('group'));
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
        $request->validate([
            'group_name' => ['required'],
        ]);
        $group = Group::find($id);
        $group->group_name = $request->group_name;
        $group->venue = $request->venue;
        $group->order_of_the_day = $request->order_of_the_day;
        $group->day_of_the_week = $request->day_of_the_week;
        $group->meeting_frequency = $request->meeting_frequency;
        $group->save();
        activity()->on($group)
            ->withProperties(['id' => $group->id])
            ->log('Update Client Group');
        \flash(trans_choice("core::general.successfully_saved", 1))->success()->important();
        return redirect('client/group');
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        //
        $group = Group::find($id);
        $group->delete();
        activity()->on($group)
            ->withProperties(['id' => $group->id])
            ->log('Delete Client Group');
        \flash(trans_choice("core::general.successfully_deleted", 1))->success()->important();
        return redirect()->back();
    }
}
