<?php

namespace Modules\Savings\Http\Controllers\Api\v1;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Modules\Accounting\Entities\JournalEntry;
use Modules\Client\Entities\Client;
use Modules\Core\Entities\PaymentDetail;
use Modules\CustomField\Entities\CustomField;
use Modules\Loan\Entities\Loan;
use Modules\Loan\Entities\LoanTransaction;
use Modules\Savings\Entities\Savings;
use Modules\Savings\Entities\SavingsCharge;
use Modules\Savings\Entities\SavingsLinkedCharge;
use Modules\Savings\Entities\SavingsProduct;
use Modules\Savings\Entities\SavingsTransaction;
use Modules\Savings\Events\SavingsStatusChanged;
use Modules\Savings\Events\TransactionUpdated;
use Modules\Savings\Events\SavingsWithdrawal;
use Yajra\DataTables\Facades\DataTables;
use Modules\User\Entities\Register;

class SavingsController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
        $this->middleware(['permission:savings.savings.index'])->only(['index', 'show']);
        $this->middleware(['permission:savings.savings.create'])->only(['create', 'store']);
        $this->middleware(['permission:savings.savings.edit'])->only(['edit', 'update', 'change_savings_officer']);
        $this->middleware(['permission:savings.savings.destroy'])->only(['destroy']);
        $this->middleware(['permission:savings.savings.approve_savings'])->only(['approve_savings', 'undo_approval', 'reject_savings', 'undo_rejection']);
        $this->middleware(['permission:savings.savings.activate_savings'])->only(['activate_savings', 'undo_activation']);
        $this->middleware(['permission:savings.savings.withdraw_savings'])->only(['withdraw_savings', 'undo_withdrawn']);
        $this->middleware(['permission:savings.savings.inactive_savings'])->only(['inactive_savings', 'undo_inactive']);
        $this->middleware(['permission:savings.savings.dormant_savings'])->only(['dormant_savings', 'undo_dormant']);
        $this->middleware(['permission:savings.savings.close_savings'])->only(['close_savings', 'undo_closed']);
        $this->middleware(['permission:savings.savings.transactions.create'])->only(['create_transaction', 'store_transaction', 'create_deposit', 'store_deposit', 'create_savings_linked_charge', 'store_savings_linked_charge', 'pay_charge', 'store_pay_charge', 'create_withdrawal', 'store_withdrawal']);
        $this->middleware(['permission:savings.savings.transactions.edit'])->only(['waive_interest', 'update_transaction', 'edit_transaction', 'waive_charge', 'edit_deposit', 'update_deposit', 'edit_withdrawal', 'update_withdrawal']);
        $this->middleware(['permission:savings.savings.transactions.destroy'])->only(['destroy_transaction', 'reverse_transaction']);
    }

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index(Request $request)
    {
        $limit = $request->limit ? $request->limit : 20;
        $status = $request->status;
        $client_id = $request->client_id;
        $savings_officer_id = $request->savings_officer_id;
        $data1 = DB::table("savings")
            ->leftJoin("clients", "clients.id", "savings.client_id")
            ->leftJoin("savings_transactions", "savings_transactions.savings_id", "savings.id")
            ->leftJoin("savings_products", "savings_products.id", "savings.savings_product_id")
            ->leftJoin("branches", "branches.id", "savings.branch_id")->leftJoin("users", "users.id", "savings.savings_officer_id")
            ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) savings_officer,savings.id,savings.client_id,savings.interest_rate,savings.activated_on_date,savings_products.name savings_product,savings.status,savings.decimals, savings.balance_derived, branches.name branch, COALESCE(SUM(savings_transactions.credit)-SUM(savings_transactions.debit),0) balance")->when($status, function ($query) use ($status) {
                $query->where("savings.status", $status);
            })->when($client_id, function ($query) use ($client_id) {
                $query->where("savings.client_id", $client_id);
            })->when($savings_officer_id, function ($query) use ($savings_officer_id) {
                $query->where("savings.savings_officer_id", $savings_officer_id);
            })->groupBy("savings.id")->paginate($limit);
        $data = Savings::with('savings_product')
                        ->with('client')->with('branch')
                        ->with('group')->with('savings_officer')
                        ->with('transactions')
                        ->with('transactions.payment_detail')
                        ->with('transactions.payment_detail.payment_type')->get();
        return response()->json([$data]);
    }

    public function get_custom_fields()
    {
        $custom_fields = CustomField::where('category', 'add_savings')->where('active', 1)->get();
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
            'client_id' => ['required'],            
        ]);
        // 
        $savings_product = SavingsProduct::where('auto_create', 1)->first();
        $savings_product_id = $savings_product->id;
        // 
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings_product = SavingsProduct::find($savings_product_id);
            $client = Client::find($request->client_id);
            $savings = new Savings();
            $savings->currency_id = $savings_product->currency_id;
            $savings->created_by_id = Auth::id();
            $savings->client_id = $request->client_id;
            $savings->savings_product_id = $savings_product_id;
            $savings->savings_officer_id = Auth::id();
            $savings->branch_id = $client->branch_id;
            $savings->group_id = $client->group_id;
            $savings->interest_rate = $savings_product->default_interest_rate;
            $savings->interest_rate_type = $savings_product->interest_rate_type;
            $savings->compounding_period = $savings_product->compounding_period;
            $savings->interest_posting_period_type = $savings_product->interest_posting_period_type;
            $savings->decimals = $savings_product->decimals;
            $savings->interest_calculation_type = $savings_product->interest_calculation_type;
            $savings->automatic_opening_balance = $request->automatic_opening_balance;
            $savings->lockin_period = $savings_product->lockin_period;
            $savings->lockin_type = $savings_product->lockin_type;
            $savings->allow_overdraft = $savings_product->allow_overdraft;
            $savings->overdraft_limit = $savings_product->overdraft_limit;
            $savings->overdraft_interest_rate = $savings_product->overdraft_interest_rate;
            $savings->minimum_overdraft_for_interest = $savings_product->minimum_overdraft_for_interest;
            $savings->automatic_opening_balance = 0;
            $savings->submitted_on_date = date('Y-m-d');
            $savings->submitted_by_user_id = Auth::id();
            $savings->status = 'active';
            $savings->activated_on_date = date('Y-m-d');
            $savings->activated_by_user_id = Auth::id();
            $savings->approved_on_date = date('Y-m-d');
            $savings->approved_by_user_id = Auth::id();
            $savings->save();
            //save charges
            if (!empty($request->charges)) {
                foreach ($request->charges as $key => $value) {
                    $savings_charge = SavingsCharge::find($key);
                    $savings_linked_charge = new SavingsLinkedCharge();
                    $savings_linked_charge->savings_id = $savings->id;
                    $savings_linked_charge->name = $savings_charge->name;
                    $savings_linked_charge->savings_charge_id = $key;
                    if ($savings_linked_charge->allow_override == 1) {
                        $savings_linked_charge->amount = $value;
                    } else {
                        $savings_linked_charge->amount = $savings_charge->amount;
                    }
                    $savings_linked_charge->savings_charge_type_id = $savings_charge->savings_charge_type_id;
                    $savings_linked_charge->savings_charge_option_id = $savings_charge->savings_charge_option_id;
                    $savings_linked_charge->save();
                }
            }
            custom_fields_save_form('add_savings', $request, $savings->id);
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    /**
     * Activate a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function activate_client_savings(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'client_id' => ['required'],           
        ]);
        // 
        $savings_product = SavingsProduct::where('auto_create', 1)->first();
        $savings_product_id = $savings_product->id;
        // 
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            // $savings_product = SavingsProduct::find($request->savings_product_id);
            $client = Client::find($request->client_id);
            $savings = new Savings();
            $savings->currency_id = $savings_product->currency_id;
            $savings->created_by_id = Auth::id();
            $savings->client_id = $request->client_id;
            $savings->savings_product_id = $request->savings_product_id;
            $savings->savings_officer_id = Auth::id();
            $savings->branch_id = $client->branch_id;
            $savings->group_id = $client->group_id;
            $savings->interest_rate = $savings_product->default_interest_rate;
            $savings->interest_rate_type = $savings_product->interest_rate_type;
            $savings->compounding_period = $savings_product->compounding_period;
            $savings->interest_posting_period_type = $savings_product->interest_posting_period_type;
            $savings->decimals = $savings_product->decimals;
            $savings->interest_calculation_type = $savings_product->interest_calculation_type;
            $savings->automatic_opening_balance = $request->automatic_opening_balance;
            $savings->lockin_period = $request->lockin_period;
            $savings->lockin_type = $request->lockin_type;
            $savings->allow_overdraft = $savings_product->allow_overdraft;
            $savings->overdraft_limit = $savings_product->overdraft_limit;
            $savings->overdraft_interest_rate = $savings_product->overdraft_interest_rate;
            $savings->minimum_overdraft_for_interest = $savings_product->minimum_overdraft_for_interest;
            $savings->submitted_on_date = $request->submitted_on_date;
            $savings->submitted_by_user_id = Auth::id();
            $savings->save();
            //save charges
            if (!empty($request->charges)) {
                foreach ($request->charges as $key => $value) {
                    $savings_charge = SavingsCharge::find($key);
                    $savings_linked_charge = new SavingsLinkedCharge();
                    $savings_linked_charge->savings_id = $savings->id;
                    $savings_linked_charge->name = $savings_charge->name;
                    $savings_linked_charge->savings_charge_id = $key;
                    if ($savings_linked_charge->allow_override == 1) {
                        $savings_linked_charge->amount = $value;
                    } else {
                        $savings_linked_charge->amount = $savings_charge->amount;
                    }
                    $savings_linked_charge->savings_charge_type_id = $savings_charge->savings_charge_type_id;
                    $savings_linked_charge->savings_charge_option_id = $savings_charge->savings_charge_option_id;
                    $savings_linked_charge->save();
                }
            }
            custom_fields_save_form('add_savings', $request, $savings->id);
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        $savings = Savings::with('transactions')->with('charges')->with('client')->with('savings_product')->find($id);
        $custom_fields = custom_fields_build_data_for_json(CustomField::where('category', 'add_savings')->where('active', 1)->get(), $savings);
        $savings->custom_fields = $custom_fields;
        return response()->json(['data' => $savings]);
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Response
     */
    public function edit($id)
    {
        $savings = Savings::with('transactions')->with('charges')->with('client')->with('savings_product')->find($id);
        $custom_fields = custom_fields_build_data_for_json(CustomField::where('category', 'add_savings')->where('active', 1)->get(), $savings);
        $savings->custom_fields = $custom_fields;
        return response()->json(['data' => $savings]);
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
            'client_id' => ['required'],
            'savings_product_id' => ['required'],
            'automatic_opening_balance' => ['required', 'numeric'],
            'lockin_period' => ['required', 'numeric'],
            'charges' => ['array'],
            'lockin_type' => ['required'],
            'submitted_on_date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings_product = SavingsProduct::find($request->savings_product_id);
            $client = Client::find($request->client_id);
            $savings = Savings::find($id);
            $savings->currency_id = $savings_product->currency_id;
            $savings->client_id = $request->client_id;
            $savings->savings_product_id = $request->savings_product_id;
            $savings->savings_officer_id = $request->savings_officer_id;
            $savings->branch_id = $client->branch_id;
            $savings->interest_rate = $request->interest_rate;
            $savings->interest_rate_type = $savings_product->interest_rate_type;
            $savings->compounding_period = $savings_product->compounding_period;
            $savings->interest_posting_period_type = $savings_product->interest_posting_period_type;
            $savings->decimals = $savings_product->decimals;
            $savings->interest_calculation_type = $savings_product->interest_calculation_type;
            $savings->automatic_opening_balance = $request->automatic_opening_balance;
            $savings->lockin_period = $request->lockin_period;
            $savings->lockin_type = $request->lockin_type;
            $savings->allow_overdraft = $savings_product->allow_overdraft;
            $savings->overdraft_limit = $savings_product->overdraft_limit;
            $savings->overdraft_interest_rate = $savings_product->overdraft_interest_rate;
            $savings->minimum_overdraft_for_interest = $savings_product->minimum_overdraft_for_interest;
            $savings->submitted_on_date = $request->submitted_on_date;
            $savings->save();
            //save charges
            SavingsLinkedCharge::where('savings_id', $id)->delete();
            if (!empty($request->charges)) {
                foreach ($request->charges as $key => $value) {
                    $savings_charge = SavingsCharge::find($key);
                    $savings_linked_charge = new SavingsLinkedCharge();
                    $savings_linked_charge->savings_id = $savings->id;
                    $savings_linked_charge->name = $savings_charge->name;
                    $savings_linked_charge->savings_charge_id = $key;
                    if ($savings_linked_charge->allow_override == 1) {
                        $savings_linked_charge->amount = $value;
                    } else {
                        $savings_linked_charge->amount = $savings_charge->amount;
                    }
                    $savings_linked_charge->savings_charge_type_id = $savings_charge->savings_charge_type_id;
                    $savings_linked_charge->savings_charge_option_id = $savings_charge->savings_charge_option_id;
                    $savings_linked_charge->save();
                }
            }
            custom_fields_save_form('add_savings', $request, $savings->id);
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        Savings::destroy($id);
        return response()->json(["success" => true, "message" => trans_choice("core::general.successfully_deleted", 1)]);

    }

    public function change_savings_officer(Request $request, $id)
    {

        $validator = Validator::make($request->all(), [
            'savings_officer_id' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = savings::find($id);
            $previous_savings_officer_id = $savings->savings_officer_id;
            $savings->savings_officer_id = $request->savings_officer_id;
            $savings->save();
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function approve_savings(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'approved_on_date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::find($id);
            $previous_status = $savings->status;
            $savings->approved_by_user_id = Auth::id();
            $savings->approved_on_date = $request->approved_on_date;
            $savings->status = 'approved';
            $savings->approved_notes = $request->approved_notes;
            $savings->save();
            //fire savings status changed event
            event(new SavingsStatusChanged($savings, $previous_status));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_approval(Request $request, $id)
    {

        $savings = Savings::find($id);
        $previous_status = $savings->status;
        $savings->approved_by_user_id = null;
        $savings->approved_on_date = null;
        $savings->status = 'submitted';
        $savings->approved_notes = null;
        $savings->save();
        //fire savings status changed event
        event(new SavingsStatusChanged($savings, $previous_status));
        return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function reject_savings(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'rejected_notes' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::find($id);
            $previous_status = $savings->status;
            $savings->rejected_by_user_id = Auth::id();
            $savings->rejected_on_date = date("Y-m-d");
            $savings->status = 'rejected';
            $savings->rejected_notes = $request->rejected_notes;
            $savings->save();
            //fire savings status changed event
            event(new SavingsStatusChanged($savings, $previous_status));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_rejection(Request $request, $id)
    {

        $savings = Savings::find($id);
        $previous_status = $savings->status;
        $savings->rejected_by_user_id = null;
        $savings->rejected_on_date = null;
        $savings->status = 'submitted';
        $savings->rejected_notes = null;
        $savings->save();
        //fire savings status changed event
        event(new SavingsStatusChanged($savings, $previous_status));
        return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function withdraw_savings(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'withdrawn_notes' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::find($id);
            $previous_status = $savings->status;
            $savings->withdrawn_by_user_id = Auth::id();
            $savings->withdrawn_on_date = date("Y-m-d");
            $savings->status = 'withdrawn';
            $savings->withdrawn_notes = $request->withdrawn_notes;
            $savings->save();
            //fire savings status changed event
            event(new SavingsStatusChanged($savings, $previous_status));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_withdrawn(Request $request, $id)
    {

        $savings = Savings::find($id);
        $previous_status = $savings->status;
        $savings->withdrawn_by_user_id = null;
        $savings->withdrawn_on_date = null;
        $savings->status = 'submitted';
        $savings->withdrawn_notes = null;
        $savings->save();
        //fire savings status changed event
        event(new SavingsStatusChanged($savings, $previous_status));
        return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function activate_savings(Request $request, $id)
    {

        $validator = Validator::make($request->all(), [
            'activated_on_date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::find($id);
            if ($savings->charges->where('savings_charge_type_id', 1)->sum('amount') > $savings->automatic_opening_balance) {
                return response()->json(["success" => false, "message" => trans('savings::general.charges_greater_than_opening_balance')], 400);
            }
            $previous_status = $savings->status;
            $savings->activated_by_user_id = Auth::id();
            $savings->activated_on_date = $request->activated_on_date;
            $savings->status = 'active';
            $savings->activated_notes = $request->activated_notes;
            //determine next interest calculation day
            $monthly_dates = [];
            $biannual_dates = [];
            $annual_dates = [];
            for ($i = 0; $i < 12; $i++) {
                array_push($monthly_dates, ["date" => Carbon::today()->startOfYear()->endOfMonth()->addMonthNoOverflow($i)->format("Y-m-d")]);
                if ($i == 5 || $i == 11) {
                    array_push($biannual_dates, ["date" => Carbon::today()->startOfYear()->endOfMonth()->addMonthNoOverflow($i)->format("Y-m-d")]);

                }
                if ($i == 11) {
                    array_push($annual_dates, ["date" => Carbon::today()->startOfYear()->endOfMonth()->addMonthNoOverflow($i)->format("Y-m-d")]);

                }
            }
            $monthly_dates = collect($monthly_dates);
            $biannual_dates = collect($biannual_dates);
            $annual_dates = collect($annual_dates);
            $next_interest_posting_date = '';
            $next_interest_calculation_date = '';
            if ($savings->interest_posting_period_type == 'monthly') {
                $next_interest_posting_date = $monthly_dates->where('date', '>=', Carbon::today())->first()['date'];
            }
            if ($savings->interest_posting_period_type == 'biannual') {
                $next_interest_posting_date = $biannual_dates->where('date', '>=', Carbon::today())->first()['date'];
            }
            if ($savings->interest_posting_period_type == 'annually') {
                $next_interest_posting_date = $annual_dates->where('date', '>=', Carbon::today())->first()['date'];
            }
            if ($savings->compounding_period == 'daily') {
                $next_interest_calculation_date = Carbon::today()->format("Y-m-d");
            }
            if ($savings->compounding_period == 'weekly') {
                $next_interest_calculation_date = Carbon::today()->endOfWeek()->format("Y-m-d");
            }
            if ($savings->compounding_period == 'monthly') {
                $next_interest_calculation_date = $monthly_dates->where('date', '>=', Carbon::today())->first()['date'];
            }
            if ($savings->compounding_period == 'biannual') {
                $next_interest_calculation_date = $biannual_dates->where('date', '>=', Carbon::today())->first()['date'];
            }
            if ($savings->compounding_period == 'annually') {
                $next_interest_calculation_date = $annual_dates->where('date', '>=', Carbon::today())->first()['date'];
            }
            $savings->start_interest_calculation_date = $next_interest_calculation_date;
            $savings->next_interest_calculation_date = $next_interest_calculation_date;
            $savings->start_interest_posting_date = $next_interest_posting_date;
            $savings->next_interest_posting_date = $next_interest_posting_date;
            $savings->save();
            if ($savings->automatic_opening_balance > 0) {
                //add automatic opening balance transaction
                $savings_transaction = new SavingsTransaction();
                $savings_transaction->created_by_id = Auth::id();
                $savings_transaction->branch_id = $savings->branch_id;
                $savings_transaction->savings_id = $savings->id;
                $savings_transaction->name = trans_choice('savings::general.deposit', 1);
                $savings_transaction->savings_transaction_type_id = 1;
                $savings_transaction->submitted_on = $savings->activated_on_date;
                $savings_transaction->created_on = date("Y-m-d");
                $savings_transaction->amount = $savings->automatic_opening_balance;
                $savings_transaction->credit = $savings->automatic_opening_balance;
                $savings_transaction->reversible = 1;
                $automatic_opening_balance_transaction_id = $savings_transaction->id;
                $savings_transaction->save();
                if ($savings->savings_product->accounting_rule == 'cash') {
                    //credit account
                    $journal_entry = new JournalEntry();
                    $journal_entry->created_by_id = Auth::id();
                    $journal_entry->transaction_number = 'S' . $automatic_opening_balance_transaction_id;
                    $journal_entry->branch_id = $savings->branch_id;
                    $journal_entry->currency_id = $savings->currency_id;
                    $journal_entry->chart_of_account_id = $savings->savings_product->savings_control_chart_of_account_id;
                    $journal_entry->transaction_type = 'savings_deposit';
                    $journal_entry->date = $savings->activated_on_date;
                    $date = explode('-', $savings->activated_on_date);
                    $journal_entry->month = $date[1];
                    $journal_entry->year = $date[0];
                    $journal_entry->credit = $savings->automatic_opening_balance;
                    $journal_entry->reference = $savings->id;
                    $journal_entry->save();
                    //debit account
                    $journal_entry = new JournalEntry();
                    $journal_entry->created_by_id = Auth::id();
                    $journal_entry->transaction_number = 'S' . $automatic_opening_balance_transaction_id;
                    $journal_entry->branch_id = $savings->branch_id;
                    $journal_entry->currency_id = $savings->currency_id;
                    $journal_entry->chart_of_account_id = $savings->savings_product->savings_reference_chart_of_account_id;
                    $journal_entry->transaction_type = 'savings_deposit';
                    $journal_entry->date = $savings->activated_on_date;
                    $date = explode('-', $savings->activated_on_date);
                    $journal_entry->month = $date[1];
                    $journal_entry->year = $date[0];
                    $journal_entry->debit = $savings->automatic_opening_balance;
                    $journal_entry->reference = $savings->id;
                    $journal_entry->save();
                }
            }
            //charges
            foreach ($savings->charges->where('savings_charge_type_id', 1) as $key) {
                $savings_transaction = new SavingsTransaction();
                $savings_transaction->created_by_id = Auth::id();
                $savings_transaction->savings_id = $savings->id;
                $savings_transaction->branch_id = $savings->branch_id;
                $savings_transaction->name = trans_choice('savings::general.pay', 1) . ' ' . trans_choice('savings::general.charge', 1);
                $savings_transaction->savings_transaction_type_id = 12;
                $savings_transaction->reversible = 1;
                $savings_transaction->submitted_on = $savings->activated_on_date;
                $savings_transaction->created_on = date("Y-m-d");
                $savings_transaction->amount = $key->amount;
                $savings_transaction->debit = $key->amount;
                $savings_transaction->savings_linked_charge_id = $key->id;
                $savings_transaction->save();
                if ($savings->savings_product->accounting_rule == 'cash') {
                    //credit account
                    $journal_entry = new JournalEntry();
                    $journal_entry->created_by_id = Auth::id();
                    $journal_entry->transaction_number = 'S' . $savings_transaction->id;
                    $journal_entry->branch_id = $savings->branch_id;
                    $journal_entry->currency_id = $savings->currency_id;
                    $journal_entry->chart_of_account_id = $savings->savings_product->savings_control_chart_of_account_id;
                    $journal_entry->transaction_type = 'savings_pay_charge';
                    $journal_entry->date = $savings->activated_on_date;
                    $date = explode('-', $savings->activated_on_date);
                    $journal_entry->month = $date[1];
                    $journal_entry->year = $date[0];
                    $journal_entry->credit = $key->amount;
                    $journal_entry->reference = $savings->id;
                    $journal_entry->save();
                    //debit account
                    $journal_entry = new JournalEntry();
                    $journal_entry->created_by_id = Auth::id();
                    $journal_entry->transaction_number = 'S' . $savings_transaction->id;
                    $journal_entry->branch_id = $savings->branch_id;
                    $journal_entry->currency_id = $savings->currency_id;
                    $journal_entry->chart_of_account_id = $savings->savings_product->income_from_fees_chart_of_account_id;
                    $journal_entry->transaction_type = 'savings_pay_charge';
                    $journal_entry->date = $savings->activated_on_date;
                    $date = explode('-', $savings->activated_on_date);
                    $journal_entry->month = $date[1];
                    $journal_entry->year = $date[0];
                    $journal_entry->debit = $key->amount;
                    $journal_entry->reference = $savings->id;
                    $journal_entry->save();
                }
                $key->savings_transaction_id = $savings_transaction->id;
                $key->calculated_amount = $key->amount;
                $key->paid_amount = $key->amount;
                $key->is_paid = 1;
                $key->save();
            }
            //fire savings status changed event
            event(new SavingsStatusChanged($savings, $previous_status));
            event(new TransactionUpdated($savings));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_activation(Request $request, $id)
    {

        $savings = Savings::find($id);
        $previous_status = $savings->status;
        $savings->activated_by_user_id = null;
        $savings->activated_on_date = null;
        $savings->status = 'approved';
        $savings->activated_notes = null;
        $savings->save();
        $transactions = SavingsTransaction::where('savings_id', $savings->id)->get();
        foreach ($transactions as $transaction) {
            JournalEntry::where('transaction_number', 'S' . $transaction->id)->delete();
            $transaction->delete();
        }

        //fire savings status changed event
        event(new SavingsStatusChanged($savings, $previous_status));
        return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function close_savings(Request $request, $id)
    {

        $validator = Validator::make($request->all(), [
            'closed_notes' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::find($id);
            $previous_status = $savings->status;
            $savings->closed_by_user_id = Auth::id();
            $savings->closed_on_date = date("Y-m-d");
            $savings->status = 'closed';
            $savings->closed_notes = $request->closed_notes;
            $savings->save();
            //fire savings status changed event
            event(new SavingsStatusChanged($savings, $previous_status));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_closed(Request $request, $id)
    {

        $savings = Savings::find($id);
        $previous_status = $savings->status;
        $savings->closed_by_user_id = null;
        $savings->closed_on_date = null;
        $savings->status = 'active';
        $savings->closed_notes = null;
        $savings->save();
        //fire savings status changed event
        event(new SavingsStatusChanged($savings, $previous_status));
        return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function inactive_savings(Request $request, $id)
    {

        $validator = Validator::make($request->all(), [
            'inactive_notes' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::find($id);
            $previous_status = $savings->status;
            $savings->inactive_by_user_id = Auth::id();
            $savings->inactive_on_date = date("Y-m-d");
            $savings->status = 'inactive';
            $savings->inactive_notes = $request->inactive_notes;
            $savings->save();
            //fire savings status changed event
            event(new SavingsStatusChanged($savings, $previous_status));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_inactive(Request $request, $id)
    {

        $savings = Savings::find($id);
        $previous_status = $savings->status;
        $savings->inactive_by_user_id = null;
        $savings->inactive_on_date = null;
        $savings->status = 'active';
        $savings->inactive_notes = null;
        $savings->save();
        //fire savings status changed event
        event(new SavingsStatusChanged($savings, $previous_status));
        return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function dormant_savings(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'dormant_notes' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::find($id);
            $previous_status = $savings->status;
            $savings->dormant_by_user_id = Auth::id();
            $savings->inactive_on_date = date("Y-m-d");
            $savings->status = 'dormant';
            $savings->dormant_notes = $request->dormant_notes;
            $savings->save();
            //fire savings status changed event
            event(new SavingsStatusChanged($savings, $previous_status));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_dormant(Request $request, $id)
    {

        $savings = Savings::find($id);
        $previous_status = $savings->status;
        $savings->dormant_by_user_id = null;
        $savings->dormant_on_date = null;
        $savings->status = 'active';
        $savings->dormant_notes = null;
        $savings->save();
        //fire savings status changed event
        event(new SavingsStatusChanged($savings, $previous_status));
        return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }


    public function store_deposit(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'amount' => ['required', 'numeric'],
            'date' => ['required', 'date'],
            'payment_type_id' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::with('savings_product')->find($id);
            //payment details
            $payment_detail = new PaymentDetail();
            $payment_detail->created_by_id = Auth::id();
            $payment_detail->payment_type_id = $request->payment_type_id;
            $payment_detail->amount = $request->amount;
            $payment_detail->group_id = $savings->group_id;
            $payment_detail->branch_id = $savings->branch_id;
            $payment_detail->transaction_type = 'savings_transaction';
            $payment_detail->reference = $savings->id;
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->receipt = $request->receipt;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->bank_name = $request->bank_name;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->save();

            $savings_transaction = new SavingsTransaction();
            $savings_transaction->created_by_id = Auth::id();
            $savings_transaction->savings_id = $savings->id;
            $savings_transaction->branch_id = $savings->branch_id;
            $savings_transaction->payment_detail_id = $payment_detail->id;
            $savings_transaction->name = trans_choice('savings::general.deposit', 1);
            $savings_transaction->savings_transaction_type_id = 1;
            $savings_transaction->submitted_on = $request->date;
            $savings_transaction->created_on = date("Y-m-d");
            $savings_transaction->reversible = 1;
            $savings_transaction->amount = $request->amount;
            $savings_transaction->credit = $request->amount;
            $savings_transaction->save();
            //fire transaction updated event
            event(new TransactionUpdated($savings));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }


    public function update_deposit(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'amount' => ['required', 'numeric'],
            'date' => ['required', 'date'],
            'payment_type_id' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings_transaction = SavingsTransaction::find($id);
            $savings = $savings_transaction->savings;
            //payment details
            $payment_detail = PaymentDetail::find($savings_transaction->payment_detail_id);
            $payment_detail->payment_type_id = $request->payment_type_id;
            $payment_detail->amount = $request->amount;
            $payment_detail->group_id = $savings->group_id;
            $payment_detail->branch_id = $savings->branch_id;
            $payment_detail->reference = $savings->id;
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->receipt = $request->receipt;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->bank_name = $request->bank_name;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->save();
            $savings_transaction->submitted_on = $request->date;
            $savings_transaction->amount = $request->amount;
            $savings_transaction->credit = $request->amount;
            $savings_transaction->save();
            //fire transaction updated event
            event(new TransactionUpdated($savings));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }


    public function store_withdrawal(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'amount' => ['required', 'numeric'],
            'date' => ['required', 'date'],
            // 'payment_type_id' => ['required'],
        ]);
        $register = Register::where('status', 'active')->where('user_id', Auth::id())->first();
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::with('savings_product')->find($id);
            $balance = $savings->transactions->where('reversed', 0)->sum('credit') - $savings->transactions->where('reversed', 0)->sum('debit');
            if ($request->amount > $balance && $savings->savings_product->allow_overdraft == 0) {
                return response()->json(["success" => false, "message" => trans_choice("savings::general.insufficient_balance", 1)], 400);

            }
            if ($request->amount > $balance && $savings->savings_product->allow_overdraft == 1 && $request->amount > $savings->savings_product->overdraft_limit) {
                return response()->json(["success" => false, "message" => trans_choice("savings::general.insufficient_overdraft_balance", 1)], 400);

            }
            //payment details
            $payment_detail = new PaymentDetail();
            $payment_detail->created_by_id = Auth::id();
            $payment_detail->payment_type_id = 1;
            $payment_detail->amount = $request->amount;
            $payment_detail->group_id = $savings->group_id;
            $payment_detail->branch_id = $savings->branch_id;
            $payment_detail->payment_date = $request->date;
            $payment_detail->register_id = $register->id;
            $payment_detail->transaction_type = 'savings_withdrawal';
            $payment_detail->reference = $savings->id;
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->receipt = $request->receipt;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->bank_name = $request->bank_name;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->save();
            
            $savings_transaction = new SavingsTransaction();
            $savings_transaction->created_by_id = Auth::id();
            $savings_transaction->savings_id = $savings->id;
            $savings_transaction->group_id = $savings->group_id;
            $savings_transaction->branch_id = $savings->branch_id;
            $savings_transaction->payment_detail_id = $payment_detail->id;
            $savings_transaction->register_id = $register->id;
            $savings_transaction->name = trans_choice('savings::general.withdrawal', 1);
            $savings_transaction->savings_transaction_type_id = 2;
            $savings_transaction->submitted_on = $request->date;
            $savings_transaction->created_on = $request->date;
            $savings_transaction->reversible = 1;
            $savings_transaction->amount = $request->amount;
            $savings_transaction->debit = $request->amount;
            $savings_transaction->save();

            if ($savings->savings_product->accounting_rule == 'cash') {
                //credit account
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->transaction_number = 'S' . $savings_transaction->id;
                $journal_entry->branch_id = $savings->branch_id;
                $journal_entry->currency_id = $savings->currency_id;
                $journal_entry->chart_of_account_id = Auth::user()->user_control_account;
                $journal_entry->transaction_type = 'savings_withdrawal';
                $journal_entry->date = $request->date;
                $date = explode('-', $request->date);
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
                $journal_entry->credit = $savings_transaction->amount;
                $journal_entry->reference = $savings->id;
                $journal_entry->save();
                //debit account
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->transaction_number = 'S' . $savings_transaction->id;
                $journal_entry->branch_id = $savings->branch_id;
                $journal_entry->currency_id = $savings->currency_id;
                $journal_entry->chart_of_account_id = $savings->savings_product->savings_control_chart_of_account_id;
                $journal_entry->transaction_type = 'savings_withdrawal';
                $journal_entry->date = $request->date;
                $date = explode('-', $request->date);
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
                $journal_entry->debit = $savings_transaction->amount;
                $journal_entry->reference = $savings->id;
                $journal_entry->save();
            }

            activity()->on($savings)
                        ->withProperties(['id' => $savings->id])
                        ->log('Create Savings Withdrawal');
            //fire transaction updated event
            $savings2 = Savings::with('savings_product')->find($id);
            event(new TransactionUpdated($savings2));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function savings_withdrawal_to_loan(Request $request)
    {


        $validator = Validator::make($request->all(), [
            'withdrawal_id'=> ['required', 'numeric'],
            'withdrawal_amount' => ['required', 'numeric'],
            'withdrawal_loan'=> ['required', 'numeric'],
            'date' => ['required']
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings = Savings::with('savings_product')->find($request->withdrawal_id);
            $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;
            $balance = $savings->transactions->where('reversed', 0)->sum('credit') - $savings->transactions->where('reversed', 0)->sum('debit');
            if ($request->withdrawal_amount > $balance && $savings->savings_product->allow_overdraft == 0) {
                return response()->json(["success" => false, "message" => trans_choice("savings::general.insufficient_balance", 1)], 400);

            }
            if ($request->withdrawal_amount > $balance && $savings->savings_product->allow_overdraft == 1 && $request->withdrawal_amount > $savings->savings_product->overdraft_limit) {
                return response()->json(["success" => false, "message" => trans_choice("savings::general.insufficient_overdraft_balance", 1)], 400);

            }      
            //payment details
            $payment_detail = new PaymentDetail();
            $payment_detail->created_by_id = Auth::id();
            $payment_detail->payment_type_id = 1;
            $payment_detail->amount = $request->withdrawal_amount;
            $payment_detail->group_id = $savings->group_id;
            $payment_detail->branch_id = $savings->branch_id;
            $payment_detail->payment_date = $request->date;
            $payment_detail->register_id = $reg_id;
            $payment_detail->transaction_type = 'loan_repayment';
            $payment_detail->reference = $savings->id;
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->receipt = $request->receipt;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->bank_name = $request->bank_name;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->save();

            $savings_transaction = new SavingsTransaction();
            $savings_transaction->created_by_id = Auth::id();
            $savings_transaction->savings_id = $savings->id;
            $savings_transaction->branch_id = $savings->branch_id;
            $savings_transaction->group_id = $savings->group_id;
            $savings_transaction->register_id = $reg_id;
            $savings_transaction->payment_detail_id = $payment_detail->id;
            $savings_transaction->name = trans_choice('savings::general.withdrawal', 1);
            $savings_transaction->savings_transaction_type_id = 7;
            $savings_transaction->submitted_on = date("Y-m-d");
            $savings_transaction->created_on = date("Y-m-d");
            $savings_transaction->reversible = 1;
            $savings_transaction->amount = $request->withdrawal_amount;
            $savings_transaction->debit = $request->withdrawal_amount;
            $savings_transaction->save();

            activity()->on($savings)
                        ->withProperties(['id' => $savings->id])
                        ->log('Create Savings Withdrawal');
            //fire transaction updated event   

            // $save = event(new TransactionUpdated($savings));           
            $this->loan_repayment_with_savings($request->withdrawal_loan, $request->withdrawal_amount, $request->withdrawal_id, $savings->savings_product->savings_control_chart_of_account_id, $request->date);
            return response()->json(['data' => $savings, "message" => "Transaction completed.", "success" => true]);
        }
    }

    public function loan_repayment_with_savings($id, $amount, $savings_id, $chart_id, $date)
    {
        $loan = Loan::with('loan_product')->find($id);
        $savings = Savings::with('savings_product')->find($savings_id);
        $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;

        //payment details
        $payment_detail = new PaymentDetail();
        $payment_detail->created_by_id = Auth::id();
        $payment_detail->payment_type_id = 1;
        $payment_detail->amount = $amount;
        $payment_detail->group_id = $loan->group_id;
        $payment_detail->branch_id = $loan->branch_id;
        $payment_detail->payment_date = date('Y-m-d');
        $payment_detail->register_id = $reg_id;
        $payment_detail->transaction_type = 'recovery_repayment';
        $payment_detail->reference = $loan->id;
        $payment_detail->cheque_number = '';
        $payment_detail->receipt = '';
        $payment_detail->account_number = '';
        $payment_detail->bank_name = '';
        $payment_detail->routing_code = '';
        $payment_detail->save();
        
        $loan_transaction = new LoanTransaction();
        $loan_transaction->created_by_id = Auth::id();
        $loan_transaction->loan_id = $loan->id;
        $loan_transaction->branch_id = $loan->branch_id;
        $loan_transaction->group_id = $loan->group_id;
        $loan_transaction->register_id = $reg_id;
        $loan_transaction->payment_detail_id = $payment_detail->id;
        $loan_transaction->name = trans_choice('loan::general.repayment', 1);
        $loan_transaction->loan_transaction_type_id = 8;
        $loan_transaction->submitted_on = date("Y-m-d");
        $loan_transaction->created_on = date("Y-m-d");
        $loan_transaction->amount = $amount;
        $loan_transaction->credit = $amount;
        $loan_transaction->save();

        activity()->on($loan_transaction)
        ->withProperties(['id' => $loan_transaction->id])
        ->log('Create Loan Repayment');
        //fire transaction updated event
        event(new SavingsWithdrawal($loan, $chart_id));
        event(new TransactionUpdated($savings));     

        // create a new repayment schedule
        app('Modules\Loan\Http\Controllers\Api\v1\LoanController')->create_repayment_schedule($loan->id, $amount, $date);
    }


    public function update_withdrawal(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'amount' => ['required', 'numeric'],
            'date' => ['required', 'date'],
            'payment_type_id' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings_transaction = SavingsTransaction::find($id);
            $savings = $savings_transaction->savings;
            //payment details
            $payment_detail = PaymentDetail::find($savings_transaction->payment_detail_id);
            $payment_detail->payment_type_id = $request->payment_type_id;
            $payment_detail->amount = $request->amount;
            $payment_detail->group_id = $savings->group_id;
            $payment_detail->branch_id = $savings->group_id;
            $payment_detail->reference = $savings->id;
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->receipt = $request->receipt;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->bank_name = $request->bank_name;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->save();
            $savings_transaction->submitted_on = $request->date;
            $savings_transaction->amount = $request->amount;
            $savings_transaction->debit = $request->amount;
            $savings_transaction->save();
            //fire transaction updated event
            event(new TransactionUpdated($savings));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    //transactions
    public function show_transaction($id)
    {
        $savings_transaction = SavingsTransaction::with('payment_detail')->with('savings')->find($id);
        return response()->json(['data' => $savings_transaction]);
    }


    public function edit_transaction($id)
    {
        $savings_transaction = SavingsTransaction::with('payment_detail')->with('savings')->find($id);
        return response()->json(['data' => $savings_transaction]);
    }

    public function update_transaction(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'amount' => ['required', 'numeric'],
            'date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings_transaction = SavingsTransaction::find($id);
            $savings_transaction_previous_amount = $savings_transaction->amount;
            $savings = $savings_transaction->savings;
            //payment details
            if ($savings_transaction->payment_detail) {
                $payment_detail = PaymentDetail::find($savings_transaction->payment_detail_id);
                $payment_detail->payment_type_id = $request->payment_type_id;
                $payment_detail->amount = $request->amount;
                $payment_detail->group_id = $savings->group_id;
                $payment_detail->branch_id = $savings->branch_id;
                $payment_detail->reference = $savings->id;
                $payment_detail->cheque_number = $request->cheque_number;
                $payment_detail->receipt = $request->receipt;
                $payment_detail->account_number = $request->account_number;
                $payment_detail->bank_name = $request->bank_name;
                $payment_detail->routing_code = $request->routing_code;
                $payment_detail->save();
            }
            $savings_transaction->submitted_on = $request->date;
            $savings_transaction->amount = $request->amount;
            if ($savings_transaction->savings_transaction_type_id == 1) {
                $savings_transaction->credit = $request->amount;
            }
            if ($savings_transaction->savings_transaction_type_id == 2 || $savings_transaction->savings_transaction_type_id == 12) {
                $savings_transaction->debit = $request->amount;
            }
            $savings_transaction->credit = $request->amount;
            $savings_transaction->save();
            if ($savings_transaction->savings_transaction_type_id == 12) {
                if (!empty($savings_transaction->savings_linked_charge)) {
                    $savings_transaction->savings_linked_charge->paid_amount = $savings_transaction->savings_linked_charge->paid_amount - $savings_transaction_previous_amount + $savings_transaction->amount;
                    if ($savings_transaction->savings_linked_charge->amount <= $savings_transaction->savings_linked_charge->paid_amount) {
                        $savings_transaction->savings_linked_charge->is_paid = 1;
                    } else {
                        $savings_transaction->savings_linked_charge->is_paid = 0;
                    }
                    $savings_transaction->savings_linked_charge->save();
                }
            }
            //fire transaction updated event
            event(new TransactionUpdated($savings));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }


    public function store_savings_linked_charge(Request $request, $id)
    {
        $savings = Savings::with('savings_product')->find($id);
        $validator = Validator::make($request->all(), [
            'amount' => ['required'],
            'savings_charge_id' => ['required'],
            'date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $savings_charge = SavingsCharge::find($request->savings_charge_id);
            $savings_linked_charge = new SavingsLinkedCharge();
            $savings_linked_charge->savings_id = $savings->id;
            $savings_linked_charge->name = $savings_charge->name;
            $savings_linked_charge->savings_charge_id = $savings_charge->id;
            if ($savings_charge->allow_override == 1) {
                $savings_linked_charge->amount = $request->amount;
            } else {
                $savings_linked_charge->amount = $savings_charge->amount;
            }
            $savings_linked_charge->calculated_amount = $savings_charge->amount;
            $savings_linked_charge->savings_charge_type_id = $savings_charge->savings_charge_type_id;
            $savings_linked_charge->savings_charge_option_id = $savings_charge->savings_charge_option_id;
            $savings_linked_charge->save();
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function pay_charge($id)
    {
        $savings_linked_charge = SavingsLinkedCharge::find($id);
        return response()->json(['data' => $savings_linked_charge]);
    }

    public function store_pay_charge(Request $request, $id)
    {
        $savings_linked_charge = SavingsLinkedCharge::with('savings')->find($id);
        $savings = $savings_linked_charge->savings;

        $validator = Validator::make($request->all(), [
            'amount' => ['required', 'max:' . ($savings_linked_charge->amount - $savings_linked_charge->paid_amount)],
            'payment_type_id' => ['required'],
            'date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            //payment details
            $payment_detail = new PaymentDetail();
            $payment_detail->created_by_id = Auth::id();
            $payment_detail->payment_type_id = $request->payment_type_id;
            $payment_detail->amount = $request->amount;
            $payment_detail->group_id = $savings->group_id;
            $payment_detail->branch_id = $savings->branch_id;
            $payment_detail->reference = $savings->id;
            $payment_detail->transaction_type = 'savings_transaction';
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->receipt = $request->receipt;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->bank_name = $request->bank_name;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->save();
            $savings_transaction = new SavingsTransaction();
            $savings_transaction->created_by_id = Auth::id();
            $savings_transaction->savings_id = $savings->id;
            $savings_transaction->branch_id = $savings->branch_id;
            $savings_transaction->payment_detail_id = $payment_detail->id;
            $savings_transaction->name = trans_choice('savings::general.pay', 1) . ' ' . trans_choice('savings::general.charge', 1);
            $savings_transaction->savings_transaction_type_id = 12;
            $savings_transaction->submitted_on = $request->date;
            $savings_transaction->created_on = date("Y-m-d");
            $savings_transaction->reversible = 1;
            $savings_transaction->amount = $request->amount;
            $savings_transaction->debit = $request->amount;
            $savings_transaction->savings_linked_charge_id = $id;
            $savings_transaction->save();
            $savings_linked_charge->paid_amount = $savings_linked_charge->paid_amount + $request->amount;
            if ($savings_linked_charge->amount <= $savings_linked_charge->paid_amount) {
                $savings_linked_charge->is_paid = 1;
            }
            $savings_linked_charge->save();
            event(new TransactionUpdated($savings));
            return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function reverse_transaction(Request $request, $id)
    {

        $savings_transaction = SavingsTransaction::find($id);
        $savings = $savings_transaction->savings;
        if ($savings_transaction->savings_transaction_type_id == 12) {
            if (!empty($savings_transaction->savings_linked_charge)) {
                $savings_transaction->savings_linked_charge->paid_amount = $savings_transaction->savings_linked_charge->paid_amount - $savings_transaction->amount;
                if ($savings_transaction->savings_linked_charge->amount <= $savings_transaction->savings_linked_charge->paid_amount) {
                    $savings_transaction->savings_linked_charge->is_paid = 1;
                } else {
                    $savings_transaction->savings_linked_charge->is_paid = 0;
                }
                $savings_transaction->savings_linked_charge->save();
            }
        }
        if ($savings_transaction->debit > $savings_transaction->credit) {
            $savings_transaction->credit = $savings_transaction->debit;
        } else {
            $savings_transaction->debit = $savings_transaction->credit;
        }
        $savings_transaction->reversed = 1;
        $savings_transaction->reversible = 0;
        $savings_transaction->save();
        event(new TransactionUpdated($savings));
        return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function get_savings(Request $request, $client_id)
    {
        $status = $request->status;
        // $client_id = $request->client_id;
        $savings_officer_id = $request->savings_officer_id;

        $query = DB::table("savings")
            ->leftJoin("clients", "clients.id", "savings.client_id")
            ->leftJoin("savings_transactions", "savings_transactions.savings_id", "savings.id")
            ->leftJoin("savings_products", "savings_products.id", "savings.savings_product_id")
            ->leftJoin("branches", "branches.id", "savings.branch_id")->leftJoin("users", "users.id", "savings.savings_officer_id")
            ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) savings_officer,savings.id,savings.client_id,savings.interest_rate,savings.activated_on_date,savings.account_number,savings_products.name savings_product,savings.status,savings.decimals,branches.name branch, COALESCE(SUM(savings_transactions.credit)-SUM(savings_transactions.debit),0) balance")->when($status, function ($query) use ($status) {
                $query->where("savings.status", 'active');
            })->when($client_id, function ($query) use ($client_id) {
                $query->where("savings.client_id", $client_id);
            })->when($savings_officer_id, function ($query) use ($savings_officer_id) {
                $query->where("savings.savings_officer_id", $savings_officer_id);
            })->groupBy("savings.id");
        return DataTables::of($query)->editColumn('client', function ($data) {
            return '<a href="' . url('client/' . $data->client_id . '/show') . '">' . $data->client . '</a>';
        })->editColumn('balance', function ($data) {
            return number_format($data->balance, $data->decimals);
        })->editColumn('interest_rate', function ($data) {
            return number_format($data->interest_rate, 2);
        })->editColumn('status', function ($data) {
            if ($data->status == 'pending') {
                return '<span class="label label-warning">' . trans_choice('savings::general.pending', 1) . ' ' . trans_choice('savings::general.approval', 1) . '</span>';
            }
            if ($data->status == 'submitted') {
                return '<span class="label label-warning">' . trans_choice('savings::general.pending_approval', 1) . '</span>';
            }
            if ($data->status == 'overpaid') {
                return '<span class="label label-warning">' . trans_choice('savings::general.overpaid', 1) . '</span>';
            }
            if ($data->status == 'approved') {
                return '<span class="label label-warning">' . trans_choice('savings::general.awaiting_activation', 1) . '</span>';
            }
            if ($data->status == 'active') {
                return '<span class="label label-info">' . trans_choice('savings::general.active', 1) . '</span>';
            }
            if ($data->status == 'rejected') {
                return '<span class="label label-danger">' . trans_choice('savings::general.rejected', 1) . '</span>';
            }
            if ($data->status == 'withdrawn') {
                return '<span class="label label-danger">' . trans_choice('savings::general.withdrawn', 1) . '</span>';
            }
            if ($data->status == 'dormant') {
                return '<span class="label label-warning">' . trans_choice('savings::general.dormant', 1) . '</span>';
            }
            if ($data->status == 'closed') {
                return '<span class="label label-success">' . trans_choice('savings::general.closed', 1) . '</span>';
            }
            if ($data->status == 'inactive') {
                return '<span class="label label-warning">' . trans_choice('savings::general.inactive', 1) . '</span>';
            }

        })->editColumn('action', function ($data) {

            $action = '<a href="' . url('savings/' . $data->id . '/show') . '" class="btn btn-info">' . trans_choice('general.detail', 2) . '</a>';

            return $action;
        })->editColumn('id', function ($data) {
            return '<a href="' . url('savings/' . $data->id . '/show') . '" class="">' . $data->id . '</a>';

        })->rawColumns(['id', 'client', 'action', 'status'])->make(true);

    }

}
