<?php

namespace Modules\Client\Http\Controllers\Api\v1;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Laracasts\Flash\Flash;
use Modules\Branch\Entities\Branch;
use Modules\Client\Entities\Client;
use Modules\Loan\Entities\Loan;
use Modules\Client\Entities\ClientType;
use Modules\Client\Entities\ClientUser;
use Modules\Client\Entities\Profession;
use Modules\Client\Entities\Title;
use Modules\Core\Entities\Country;
use Modules\CustomField\Entities\CustomField;
use Modules\User\Entities\User;
use Spatie\Permission\Models\Role;
use Yajra\DataTables\Facades\DataTables;
use Carbon\Carbon;
use Modules\Client\Entities\Group;
use Illuminate\Support\Str;
use Modules\Client\Imports\ClientImport;
use Maatwebsite\Excel\Facades\Excel;

class ClientController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
        $this->middleware(['permission:client.clients.index'])->only(['index', 'show', 'get_clients']);
        $this->middleware(['permission:client.clients.create'])->only(['create', 'store']);
        $this->middleware(['permission:client.clients.edit'])->only(['edit', 'update']);
        $this->middleware(['permission:client.clients.destroy'])->only(['destroy']);
        $this->middleware(['permission:client.clients.user.create'])->only(['store_user', 'create_user']);
        $this->middleware(['permission:client.clients.user.destroy'])->only(['destroy_user']);
        $this->middleware(['permission:client.clients.activate'])->only(['change_status']);

    }

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index(Request $request)
    {
        $status = $request->status;
        $branch_id = $request->branch_id;
        $limit = $request->limit ? $request->limit : 20;
        $data = DB::table("clients")
            ->leftJoin("branches", "branches.id", "clients.branch_id")
            ->leftJoin("users", "users.id", "clients.loan_officer_id")
            ->selectRaw("branches.name branch,concat(users.first_name,' ',users.last_name) staff,clients.id,clients.loan_officer_id,concat(clients.first_name,' ',clients.last_name) name,clients.gender,clients.mobile,clients.email,clients.external_id,clients.status")
            ->when($status, function ($query) use ($status) {
                $query->where('status', $status);
            })->when($branch_id, function ($query) use ($branch_id) {
                $query->where('branch_id', $branch_id);
            })->paginate($limit);
        return response()->json([$data]);
    }

    public function get_custom_fields()
    {
        $custom_fields = CustomField::where('category', 'add_client')->where('active', 1)->get();
        return response()->json(['data' => $custom_fields]);
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'first_name' => ['required'],
            'last_name' => ['required'],
            'gender' => ['required'],
            'mobile' => ['required'],
            'email' => ['string', 'email', 'max:255'],
            'dob' => ['required', 'date'],
            // 'created_date' => ['required', 'date'],
            'group_id' => ['required'],
            'photo' => ['image', 'mimes:jpg,jpeg,png'],
        ]);
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        } else {
            $branch_id = Group::find($request->group_id)->branch_id;
            
            $members = count(Client::where('group_id', $request->group_id)->get());
            $reference = ($this->groupCode($request->group_id).''.Str::padLeft($members + 1, 5, '0'));

            $client = new Client();
            $client->first_name = $request->first_name;
            $client->last_name = $request->last_name;
            $client->external_id = $request->external_id;
            $client->created_by_id = Auth::id();
            $client->gender = strtolower($request->gender);
            $client->country_id = $request->country_id;
            $client->loan_officer_id = Auth::id();
            $client->title_id = $request->title_id;
            $client->branch_id = $branch_id;
            $client->reference= $reference;
            $client->group_id = $request->group_id;
            $client->client_type_id = 2;
            $client->profession_id = $request->profession;
            $client->mobile = $request->mobile;
            $client->notes = $request->notes;
            $client->email = $request->email;
            $client->address = $request->address;
            $client->marital_status = strtolower($request->marital_status);
            $client->created_date = date('Y-m-d');
            $request->dob ? $client->dob = $request->date : '';
            if ($request->hasFile('photo')) {
                $file_name = $request->file('photo')->store('public/uploads/clients');
                $client->photo = basename($file_name);
            }
            $client->save();
            custom_fields_save_form('add_client', $request, $client->id);
            return response()->json(['data' => $client, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function groupCode($group_id)
    {
            $group_name = Group::find($group_id)->group_name;
            $split = explode(' ', $group_name);
            $ab = array();
            foreach($split as $sp)
            {
                $inc = substr($sp, 0, 1);
                array_push($ab, $inc);
            }

            return implode('', $ab);
    }

     /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function importClients(Request $request, $id)
    {
        // return $request->users;
        $file = $request->file('files');
        // return $file->getClientOriginalName();
        if ($file) {
            $filename = $file->getClientOriginalName();
            $extension = $file->getClientOriginalExtension(); //Get extension of uploaded file
            $tempPath = $file->getRealPath();
            $fileSize = $file->getSize(); //Get size of uploaded file in bytes
            //Check for file extension and size
            $this->checkUploadedFileProperties($extension, $fileSize);
            //Where uploaded file will be stored on the server 
            $location = 'uploads'; //Created an "uploads" folder for that
            // Upload file
            $file->move($location, $filename);
            // In case the uploaded file path is to be stored in the database 
            $filepath = public_path($location . "/" . $filename);
            // Reading file
            $file = fopen($filepath, "r");

            // return $filepath;

            if(Excel::import(new ClientImport($id), $filepath))
            {
                return response()->json([
                'message' => "Records successfully uploaded"
                ]);
            
            } else {
            //no file was uploaded
            throw new \Exception('No file was uploaded', Response::HTTP_BAD_REQUEST);
            }
        }
            
    }

    public function checkUploadedFileProperties($extension, $fileSize)
    {
        $valid_extension = array("csv", "xlsx"); //Only want csv and excel files
        $maxFileSize = 2097152; // Uploaded file size limit is 2mb
        if (in_array(strtolower($extension), $valid_extension)) {
        if ($fileSize <= $maxFileSize) {
        } else {
        throw new \Exception('No file was uploaded', Response::HTTP_REQUEST_ENTITY_TOO_LARGE); //413 error
        }
        } else {
        throw new \Exception('Invalid file extension', Response::HTTP_UNSUPPORTED_MEDIA_TYPE); //415 error
        }
    }

    public function sendEmail($email, $name)
    {
        $data = array(
        'email' => $email,
        'name' => $name,
        'subject' => 'Welcome Message',
        );
        Mail::send('welcomeEmail', $data, function ($message) use ($data) {
        $message->from('welcome@myapp.com');
        $message->to($data['email']);
        $message->subject($data['subject']);
        });
    }
    // }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        $client = Client::with('client_users')->with('client_users.user')->with('identifications')->with('identifications.identification_type')->with('files')->with('next_of_kins')->with('next_of_kins.next_of_kins')->with('next_of_kins.client_relationship')->find($id);
        $custom_fields = custom_fields_build_data_for_json(CustomField::where('category', 'add_client')->where('active', 1)->get(), $client);
        $client->custom_fields = $custom_fields;
        return response()->json(['data' => $client]);
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Response
     */
    public function edit($id)
    {
        $client = Client::find($id);
        $custom_fields = custom_fields_build_data_for_json(CustomField::where('category', 'add_client')->where('active', 1)->get(), $client);
        $client->custom_fields = $custom_fields;
        return response()->json(['data' => $client]);
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function update(Request $request, $id)
    {

        $validator = Validator::make($request->all(), [
            'first_name' => ['required'],
            'last_name' => ['required'],
            'gender' => ['required'],
            'email' => ['string', 'email', 'max:255'],
            'dob' => ['required', 'date'],
            'photo' => ['image', 'mimes:jpg,jpeg,png'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $client = Client::find($id);
            $client->first_name = $request->first_name;
            $client->last_name = $request->last_name;
            $client->external_id = $request->external_id;
            $client->gender = $request->gender;
            $client->country_id = $request->country_id;
            $client->loan_officer_id = $request->loan_officer_id;
            $client->title_id = $request->title_id;
            $client->client_type_id = $request->client_type_id;
            $client->profession_id = $request->profession_id;
            $client->mobile = $request->mobile;
            $client->notes = $request->notes;
            $client->email = $request->email;
            $client->address = $request->address;
            $client->marital_status = $request->marital_status;
            $request->dob ? $client->dob = $request->dob : '';
            if ($request->hasFile('photo')) {
                $file_name = $request->file('photo')->store('public/uploads/clients');
                //check if we had a file before
                if ($client->photo) {
                    Storage::delete('public/uploads/clients/' . $client->photo);
                }
                $client->photo = basename($file_name);
            }
            $client->save();
            custom_fields_save_form('add_client', $request, $client->id);
            return response()->json(['data' => $client, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        Client::destroy($id);
        return response()->json(["success" => true, "message" => trans_choice("core::general.successfully_deleted", 1)]);

    }


    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store_user(Request $request, $id)
    {
        if ($request->existing == 1) {

            $validator = Validator::make($request->all(), [
                'user_id' => ['required'],
            ]);
            if ($validator->fails()) {
                return response()->json(["success" => false, "errors" => $validator->errors()], 400);
            } else {
                if (ClientUser::where('client_id', $id)->where('user_id', $request->user_id)->get()->count() > 0) {
                    return response()->json(["success" => true, "message" => trans_choice("client::general.user_already_added", 1)]);
                }
                $client_user = new ClientUser();
                $client_user->client_id = $id;
                $client_user->created_by_id = Auth::id();
                $client_user->user_id = $request->user_id;
                $client_user->save();
                return response()->json(["success" => true, "message" => trans_choice("core::general.successfully_saved", 1)]);
            }
        } else {
            $validator = Validator::make($request->all(), [
                'first_name' => ['required'],
                'last_name' => ['required'],
                'gender' => ['required'],
                'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
                'password' => ['required', 'string', 'min:6'],
            ]);
            if ($validator->fails()) {
                return response()->json(["success" => false, "errors" => $validator->errors()], 400);
            } else {
                $user = User::create([
                    'first_name' => $request->first_name,
                    'last_name' => $request->last_name,                    
                    'gender' => $request->gender,
                    'phone' => $request->phone,
                    'email' => $request->email,
                    'notes' => $request->notes,
                    'address' => $request->address,
                    'password' => Hash::make($request->password),
                    'email_verified_at' => date("Y-m-d H:i:s")
                ]);
                //attach client role
                $role = Role::findByName('client');
                $user->assignRole($role);
                $client_user = new ClientUser();
                $client_user->client_id = $id;
                $client_user->created_by_id = Auth::id();
                $client_user->user_id = $user->id;
                $client_user->save();
                return response()->json(["success" => true, "data" => $user, "message" => trans_choice("core::general.successfully_saved", 1)]);
            }

        }

    }

    public function destroy_user($id)
    {
        ClientUser::destroy($id);
        return response()->json(["success" => true, "message" => trans_choice("core::general.successfully_saved", 1)]);

    }

    public function change_status(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'status' => ['required'],
            // 'date' => ['required', 'date'],
        ]);
        // $status = $request->status;
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {           
            $client = Client::find($id);
            $client->status = $request->status;
            $client->activation_date = date('Y-m-d');
            $client->save();
            return response()->json(["success" => true, "message" => trans_choice("core::general.successfully_saved", 1)]);
        }
    }

    public function get_loans(Request $request, $client_id)
    {

        $status = $request->status;
        // $client_id = $request->client_id;
        $loan_officer_id = $request->loan_officer_id;
        $branch_id = $request->branch_id;
        $query = DB::table("loans")
            ->leftJoin("clients", "clients.id", "loans.client_id")
            ->leftJoin("loan_repayment_schedules", "loan_repayment_schedules.loan_id", "loans.id")
            ->leftJoin("loan_products", "loan_products.id", "loans.loan_product_id")
            ->leftJoin("branches", "branches.id", "loans.branch_id")
            ->leftJoin("users", "users.id", "loans.loan_officer_id")
            ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) loan_officer,loans.id,loans.client_id,loans.applied_amount,loans.principal,loans.disbursed_on_date,loans.expected_maturity_date,loan_products.name loan_product,loans.status,loans.decimals,branches.name branch, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived")->when($status, function ($query) use ($status) {
                $query->where("loans.status", $status);
            })->when($client_id, function ($query) use ($client_id) {
                $query->where("loans.client_id", $client_id);
            })->when($loan_officer_id, function ($query) use ($loan_officer_id) {
                $query->where("loans.loan_officer_id", $loan_officer_id);
            })->when($branch_id, function ($query) use ($branch_id) {
                $query->where("loans.branch_id", $branch_id);
            })->groupBy("loans.id");
        return DataTables::of($query)->editColumn('client', function ($data) {
            return '<a href="' . url('client/' . $data->client_id . '/show') . '">' . $data->client . '</a>';
        })->editColumn('principal', function ($data) {
            return number_format($data->principal, $data->decimals);
        })->editColumn('total_principal', function ($data) {
            return number_format($data->total_principal, $data->decimals);
        })->editColumn('total_interest', function ($data) {
            return number_format($data->total_interest, $data->decimals);
        })->editColumn('total_fees', function ($data) {
            return number_format($data->total_fees, $data->decimals);
        })->editColumn('total_penalties', function ($data) {
            return number_format($data->total_penalties, $data->decimals);
        })->editColumn('due', function ($data) {
            return number_format($data->total_principal + $data->total_interest + $data->total_fees + $data->total_penalties, $data->decimals);
        })->editColumn('balance', function ($data) {
            return number_format(($data->total_principal - $data->principal_repaid_derived - $data->principal_written_off_derived) + ($data->total_interest - $data->interest_repaid_derived - $data->interest_written_off_derived - $data->interest_waived_derived) + ($data->total_fees - $data->fees_repaid_derived - $data->fees_written_off_derived - $data->fees_waived_derived) + ($data->total_penalties - $data->penalties_repaid_derived - $data->penalties_written_off_derived - $data->penalties_waived_derived), $data->decimals);
        })->editColumn('status', function ($data) {
            if ($data->status == 'pending') {
                return '<span class="label label-warning">' . trans_choice('loan::general.pending', 1) . ' ' . trans_choice('general.approval', 1) . '</span>';
            }
            if ($data->status == 'submitted') {
                return '<span class="label label-warning">' . trans_choice('loan::general.pending_approval', 1) . '</span>';
            }
            if ($data->status == 'overpaid') {
                return '<span class="label label-warning">' . trans_choice('loan::general.overpaid', 1) . '</span>';
            }
            if ($data->status == 'approved') {
                return '<span class="label label-warning">' . trans_choice('loan::general.awaiting_disbursement', 1) . '</span>';
            }
            if ($data->status == 'active') {
                return '<span class="label label-info">' . trans_choice('loan::general.active', 1) . '</span>';
            }
            if ($data->status == 'rejected') {
                return '<span class="label label-danger">' . trans_choice('loan::general.rejected', 1) . '</span>';
            }
            if ($data->status == 'withdrawn') {
                return '<span class="label label-danger">' . trans_choice('loan::general.withdrawn', 1) . '</span>';
            }
            if ($data->status == 'written_off') {
                return '<span class="label label-danger">' . trans_choice('loan::general.written_off', 1) . '</span>';
            }
            if ($data->status == 'closed') {
                return '<span class="label label-success">' . trans_choice('loan::general.closed', 1) . '</span>';
            }
            if ($data->status == 'pending_reschedule') {
                return '<span class="label label-warning">' . trans_choice('loan::general.pending_reschedule', 1) . '</span>';
            }
            if ($data->status == 'rescheduled') {
                return '<span class="label label-info">' . trans_choice('loan::general.rescheduled', 1) . '</span>';
            }

        })->editColumn('action', function ($data) {

            $action = '<a href="' . url('loan/' . $data->id . '/show') . '" class="btn btn-info">' . trans_choice('general.detail', 2) . '</a>';

            return $action;
        })->editColumn('id', function ($data) {
            return '<a href="' . url('loan/' . $data->id . '/show') . '" class="">' . $data->id . '</a>';

        })->rawColumns(['id', 'client', 'action', 'status'])->make(true);
    }

    public function get_client_loans($client_id)
    {
        $client = Client::with(['loan_officer', 'client_group', 'title', 'loans.loan_product', 'savings'=>function($query){
            $query->leftJoin('savings_products', 'savings_products.id', 'savings.savings_product_id');
            $query->selectRaw('savings_products.name name, savings.balance_derived, savings.id as id, savings_products.id as bid, savings.client_id');
            $query->where('savings.status', 'active');
        },  'loans.repayment_schedules' => function($query){
            $query->selectRaw('loan_repayment_schedules.loan_id, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived');
            $query->groupBy('loan_repayment_schedules.loan_id');
        }])->find($client_id);

        return $client;
    }

    public function client_due_loans($client_id)
    {
        $loans = Loan::with(['transactions', 'charges', 'client', 'loan_product', 'repayment_schedules' => function($query){
            // $query->where('loan_repayment_schedules.due_date', '<=', date('Y-m-d'));
            $query->whereNull('loan_repayment_schedules.paid_by_date');
            $query->orderBy('loan_repayment_schedules.loan_id', 'ASC');
            $query->groupBy('loan_repayment_schedules.loan_id');
            $query->skip(0)->take(2);
        }])
        ->where('loans.client_id', $client_id)
        ->get();

        return $loans;
        // return Carbon::now()->toDateTimeString() .' and '. date('Y-m-d');

    }

    public function client_professions()
    {
        return Profession::all();
    }    

}
