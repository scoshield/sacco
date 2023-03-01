<?php

namespace Modules\Loan\Http\Controllers\Api\v1;

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
use Modules\Loan\Entities\LoanApplication;
use Modules\Loan\Entities\LoanCharge;
use Modules\Loan\Entities\LoanHistory;
use Modules\Loan\Entities\LoanLinkedCharge;
use Modules\Loan\Entities\LoanOfficerHistory;
use Modules\Loan\Entities\LoanProduct;
use Modules\Loan\Entities\LoanRepaymentSchedule;
use Modules\Loan\Entities\LoanTransaction;
use Modules\Loan\Events\LoanStatusChanged;
use Modules\Loan\Events\TransactionUpdated;
use Yajra\DataTables\Facades\DataTables;
use Modules\Core\Entities\PaymentType;
use Modules\User\Entities\Register;
use Modules\User\Entities\User;
use Modules\Client\Entities\Group;
use Modules\Savings\Entities\Savings;
use Modules\Savings\Entities\SavingsCharge;
use Modules\Savings\Entities\SavingsLinkedCharge;
use Modules\Savings\Entities\SavingsProduct;
use Modules\Savings\Entities\SavingsTransaction;
use Modules\Income\Entities\Income;
use Modules\Income\Entities\IncomeType;
use Modules\Client\Imports\ClientImport;
use Modules\Loan\Imports\LoanImport;
use Modules\Loan\Imports\TransactionImport;
use Maatwebsite\Excel\Facades\Excel;


class LoanController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
        $this->middleware(['permission:loan.loans.index'])->only(['index', 'get_loans', 'show', 'show_application', 'get_applications']);
        $this->middleware(['permission:loan.loans.create'])->only(['create', 'create_client_loan', 'store_client_loan', 'store']);
        $this->middleware(['permission:loan.loans.edit'])->only(['edit', 'edit_client_loan', 'update', 'update_client_loan', 'change_loan_officer']);
        $this->middleware(['permission:loan.loans.destroy'])->only(['destroy']);
        $this->middleware(['permission:loan.loans.approve_loan'])->only(['approve_loan', 'undo_approval', 'reject_loan', 'undo_rejection', 'approve_application', 'store_approve_application']);
        $this->middleware(['permission:loan.loans.disburse_loan'])->only(['disburse_loan', 'undo_disbursement']);
        $this->middleware(['permission:loan.loans.withdraw_loan'])->only(['withdraw_loan', 'undo_withdrawn']);
        $this->middleware(['permission:loan.loans.write_off_loan'])->only(['write_off_loan', 'undo_write_off']);
        $this->middleware(['permission:loan.loans.reschedule_loan'])->only(['reschedule_loan']);
        $this->middleware(['permission:loan.loans.close_loan'])->only(['close_loan', 'undo_close']);
        $this->middleware(['permission:loan.loans.calculator'])->only(['calculator']);
        $this->middleware(['permission:loan.loans.transactions.create'])->only(['create_repayment', 'store_repayment', 'create_loan_linked_charge', 'store_loan_linked_charge']);
        $this->middleware(['permission:loan.loans.transactions.edit'])->only(['edit_repayment', 'reverse_repayment', 'update_repayment', 'waive_interest', 'waive_charge']);

    }

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index(Request $request)
    {
        $limit = $request->limit ? $request->limit : 100;
        $status = $request->status;
        $client_id = $request->client_id;
        $loan_officer_id = $request->loan_officer_id;
        $branch_id = $request->branch_id;
        $data1 = DB::table("loans")
            ->leftJoin("clients", "clients.id", "loans.client_id")->leftJoin("loan_repayment_schedules", "loan_repayment_schedules.loan_id", "loans.id")
            ->leftJoin("loan_products", "loan_products.id", "loans.loan_product_id")->leftJoin("branches", "branches.id", "loans.branch_id")
            ->leftJoin("users", "users.id", "loans.loan_officer_id")
            ->leftJoin("client_groups", "client_groups.id", "clients.group_id")
            ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) loan_officer,loans.id,loans.client_id,client_groups.group_name,loans.principal,loans.applied_amount,loans.disbursed_on_date,loans.expected_maturity_date,loan_products.name loan_product,loans.status,loans.decimals,branches.name branch, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived")->when($status, function ($query) use ($status) {
                $query->where("loans.status", $status);
            })->when($client_id, function ($query) use ($client_id) {
                $query->where("loans.client_id", $client_id);
            })->when($loan_officer_id, function ($query) use ($loan_officer_id) {
                $query->where("loans.loan_officer_id", $loan_officer_id);
            })->when($branch_id, function ($query) use ($branch_id) {
                $query->where("loans.branch_id", $branch_id);
            })->groupBy("loans.id")->paginate($limit);

        $data = Loan::with('branch')->with('client')->with('branch')
                    ->with('group')->with('loan_product')->with('loan_purpose')
                    ->with('collateral')->with('guarantors')
                    ->with(['repayment_schedules'=>function($query){
                        $query->selectRaw('loan_repayment_schedules.loan_id, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived');
                        $query->groupBy('loan_repayment_schedules.loan_id');
                    }])
                    ->with('transactions')
                    // ->where('loans.disbursed_on_date', '!=', null)
                    ->get();
        return response()->json([$data]);
    }

    public function group_loans()
    {
        $limit =  request("limit");        

        $data = Group::with('branch') 
        // ->with('expenses')->with('income')
        ->with(['clients.loans' => function ($query) {
            $query->where("loans.disbursed_on_date", "=", 7);
            $query->where('loans.status', 'active');
        }])
        ->with(['clients.loans.loan_product'=>function($query){
            $query->orderBy('loan_products.id', 'asc');
        }])
        ->with('clients.savings.savings_product')
        ->with(['clients.savings'=>function($query){
            $query->where('savings.status', 'active');
            $query->groupBy('savings.client_id');
        }])
        
        ->with(['loans.repayment_schedules'=>function($query){
            $query->selectRaw('loan_repayment_schedules.loan_id, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived');
            $query->groupBy('loan_repayment_schedules.loan_id');
            // $query->where('loans.disbursed_on_date', '!=', null);
        }])
        ->where('client_groups.group_name', 'like', '%'.request("search")."%")
        ->paginate($limit);
        return response()->json([$data]);
    }

    public function group_loans_details(Request $request, $group_id)
    {
        $limit = $request->limit ? $request->limit : 100;
        $status = $request->status;
        $loan_officer_id = $request->loan_officer_id;
        $branch_id = $request->branch_id;

        $data1 = [ 
        'groups' => Group::with('expenses')->with('income') 
        ->with(['clients.loans.loan_product'=>function($query){
            // $query->where('clients.status', 'active');
            $query->orderBy('loan_products.id', 'asc');
        }])->with(['clients.loans.repayment_schedules'=>function($query){
            $query->selectRaw('loan_repayment_schedules.loan_id, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived');
            $query->groupBy('loan_repayment_schedules.loan_id');
        }])
        ->with('clients.loans.transactions')
        ->with('clients.savings.savings_product')
        ->with(['clients.savings'=>function($query){
            $query->where('savings.status', 'active');
            $query->groupBy('savings.client_id');
        }])->with(['clients.loans' => function ($query) {
            $query->where('loans.status', 'active');
        }])->find($group_id),
        'total_loans' => Group::join('loans', 'client_groups.id', 'loans.group_id')
                            ->join('loan_repayment_schedules', 'loan_repayment_schedules.loan_id', 'loans.id')
                            ->selectRaw('loan_repayment_schedules.loan_id, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived')
                            ->where('loans.status', 'active')
                            ->find($group_id),
        'total_savings' => Group::join('savings', 'client_groups.id', 'savings.group_id')
                            ->selectRaw('SUM(savings.balance_derived) savings')
                            ->where('savings.status', 'active')
                            ->find($group_id)
        ];

        return response()->json($data1);
    }

    public function application(Request $request)
    {
        $limit = $request->limit ? $request->limit : 20;
        $status = $request->status;
        $client_id = $request->client_id;
        $branch_id = $request->branch_id;

        $data = DB::table("loan_applications")->leftJoin("clients", "clients.id", "loan_applications.client_id")->leftJoin("loan_products", "loan_products.id", "loan_applications.loan_product_id")->leftJoin("branches", "branches.id", "loan_applications.branch_id")->leftJoin("users", "users.id", "loan_applications.created_by_id")->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) created_by,loan_applications.id,loan_applications.client_id,loan_products.name loan_product,loan_applications.status,loan_applications.loan_id,branches.name branch,loan_applications.amount,loan_applications.created_at")->when($status, function ($query) use ($status) {
            $query->where("loan_applications.status", $status);
        })->when($client_id, function ($query) use ($client_id) {
            $query->where("loan_applications.client_id", $client_id);
        })->when($branch_id, function ($query) use ($branch_id) {
            $query->where("loan_applications.branch_id", $branch_id);
        })->paginate($limit);
        return response()->json([$data]);
    }

    public function get_custom_fields()
    {
        $custom_fields = CustomField::where('category', 'add_loan')->where('active', 1)->get();
        return response()->json(['data' => $custom_fields]);
    }


    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {

        // start the database transaction
        // DB::transaction(function (Request $request) {

        $validator = Validator::make($request->all(), [
            'loan_product_id' => ['required'],
            'loan_purpose_id' => ['required'],
            'client_id' => ['required'],
            'applied_amount' => ['required', 'numeric'],
            'loan_term' => ['required', 'numeric'],
            'repayment_frequency_type' => ['required'],
            'interest_rate' => ['required', 'numeric'],
            'expected_disbursement_date' => ['required', 'date'],
            'charges' => ['array'],
            'expected_first_payment_date' => ['required', 'date', 'after:expected_disbursement_date'],
        ]);

        // check the client total savings
        ##############################################
        $status = $request->status;
        $client_id = $request->client_id;
        $loan_product_id = $request->loan_product_id;

        $query = DB::table("savings")
            ->leftJoin("clients", "clients.id", "savings.client_id")
            ->leftJoin("savings_transactions", "savings_transactions.savings_id", "savings.id")
            ->leftJoin("savings_products", "savings_products.id", "savings.savings_product_id")
            ->leftJoin("branches", "branches.id", "savings.branch_id")
            ->leftJoin("users", "users.id", "savings.savings_officer_id")
            ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) savings_officer,savings.id,savings.client_id,savings.interest_rate,savings.activated_on_date,savings.account_number,savings_products.name savings_product,savings.status,savings.decimals,branches.name branch, IFNULL(SUM(savings_transactions.credit),0) - IFNULL(SUM(savings_transactions.debit),0) balance, savings.balance_derived")
            ->when($status, function ($query) use ($status) {
                $query->where("savings.status", 'active');
            })->when($client_id, function ($query) use ($client_id) {
                $query->where("savings.client_id", $client_id);
            })
            ->groupBy("clients.id")->get();
        if(count($query) > 0){
            $savings = $query[0]->balance;
        }else{
            $savings = 1;
        }

        // return $savings;
        // ############################################
        // CHECK THE CLIENT LOAN PORTFOLIO
        $status = $request->status;
        $query = Loan::leftJoin("clients", "clients.id", "loans.client_id")
            ->leftJoin("loan_repayment_schedules", "loan_repayment_schedules.loan_id", "loans.id")
            ->leftJoin("loan_products", "loan_products.id", "loans.loan_product_id")
            ->leftJoin("branches", "branches.id", "loans.branch_id")
            ->leftJoin("users", "users.id", "loans.loan_officer_id")
            ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) loan_officer,loans.id,loans.client_id,loans.applied_amount,loans.principal,loans.disbursed_on_date,loans.expected_maturity_date,loan_products.name loan_product,loans.status,loans.decimals,branches.name branch, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived")->when($status, function ($query) use ($status) {
                $query->where("loans.status", 'active');
            })->when($client_id, function ($query) use ($client_id) {
                $query->where("loans.client_id", $client_id);
            })
            ->when($loan_product_id, function ($query) use ($loan_product_id) {
                $query->where("loans.loan_product_id", $loan_product_id);
            })
            ->groupBy("loans.id")->get();
        // ##################################################
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        } else {

            // Test the user loan limit
            $requested = $request->applied_amount;
            $loan_product = LoanProduct::find($request->loan_product_id);
            $multiple = number_format(($requested / $savings), 2, '.', '');

            if( $multiple > $loan_product->multiplier)
            {
                return response()->json(['message'=> 'The client can\'t borrow '. $multiple.' X savings. Loan limit is. '.number_format($loan_product->multiplier * $savings, 2, '.', ',') ], 400);
            }

            if(count($query) > 0)
            {
                $data = $query[0];
                $balance = number_format(($data->total_principal - $data->principal_repaid_derived - $data->principal_written_off_derived) + ($data->total_interest - $data->interest_repaid_derived - $data->interest_written_off_derived - $data->interest_waived_derived) + ($data->total_fees - $data->fees_repaid_derived - $data->fees_written_off_derived - $data->fees_waived_derived) + ($data->total_penalties - $data->penalties_repaid_derived - $data->penalties_written_off_derived - $data->penalties_waived_derived), 2, '.', ',');
                if($balance > 0)
                {
                    return response()->json(['message' => 'The client has an active loan for the same product. Loan amount ' . $balance], 400);
                }
            }
            $client = Client::find($request->client_id);
            $loan = new Loan();
            $loan->currency_id = $loan_product->currency_id;
            $loan->loan_product_id = $loan_product->id;
            $loan->client_id = $client->id;
            $loan->group_id = $client->group_id;
            $loan->branch_id = $client->branch_id;
            $loan->loan_transaction_processing_strategy_id = $loan_product->loan_transaction_processing_strategy_id;
            $loan->loan_purpose_id = $request->loan_purpose_id;
            $loan->loan_officer_id = Auth::id();
            $loan->expected_disbursement_date = $request->expected_disbursement_date;
            $loan->expected_first_payment_date = $request->expected_first_payment_date;
            $loan->fund_id = 1;
            $loan->created_by_id = Auth::id();
            $loan->applied_amount = $request->applied_amount;
            $loan->loan_term = $request->loan_term;
            $loan->repayment_frequency = $request->repayment_frequency;
            $loan->repayment_frequency_type = $request->repayment_frequency_type;
            $loan->interest_rate = $request->interest_rate;
            $loan->interest_rate_type = $loan_product->interest_rate_type;
            $loan->grace_on_principal_paid = $loan_product->grace_on_principal_paid;
            $loan->grace_on_interest_paid = $loan_product->grace_on_interest_paid;
            $loan->grace_on_interest_charged = $loan_product->grace_on_interest_charged;
            $loan->interest_methodology = $loan_product->interest_methodology;
            $loan->amortization_method = $loan_product->amortization_method;
            $loan->auto_disburse = $loan_product->auto_disburse;
            $loan->submitted_on_date = date("Y-m-d");
            $loan->submitted_by_user_id = Auth::id();
            $loan->save();
            //save charges
            if (!empty($request->charges)) {
                array_unique($request->charges, SORT_REGULAR);
                foreach ($request->charges as $charge) {
                    $loan_charge = LoanCharge::find($charge['id']);
                    // $recharges.push($charge);
                    $loan_linked_charge = new LoanLinkedCharge();
                    $loan_linked_charge->loan_id = $loan->id;
                    $loan_linked_charge->name = $loan_charge->name;
                    $loan_linked_charge->loan_charge_id = $charge['id'];
                    if ($loan_charge->allow_override == 1) {
                        $loan_linked_charge->amount = $charge['amount'];
                    } else {
                        $loan_linked_charge->amount = $loan_charge->amount;
                    }
                    $loan_linked_charge->loan_charge_type_id = $loan_charge->loan_charge_type_id;
                    $loan_linked_charge->loan_charge_option_id = $loan_charge->loan_charge_option_id;
                    $loan_linked_charge->is_penalty = $loan_charge->is_penalty;
                    $loan_linked_charge->save();
                }
            }
            $loan_history = new LoanHistory();
            $loan_history->loan_id = $loan->id;
            $loan_history->created_by_id = Auth::id();
            $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
            $loan_history->action = 'Loan Created';
            $loan_history->save();
            $loan_officer_history = new LoanOfficerHistory();
            $loan_officer_history->loan_id = $loan->id;
            $loan_officer_history->created_by_id = Auth::id();
            $loan_officer_history->loan_officer_id = Auth::id();
            $loan_officer_history->start_date = date("Y-m-d");
            $loan_officer_history->save();
            custom_fields_save_form('add_loan', $request, $loan->id);
            //fire loan status changed event
            event(new LoanStatusChanged($loan));
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
        // });
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show_application($id)
    {

        $loan_application = LoanApplication::with('client')->with('loan_product')->find($id);
        return response()->json(['data' => $loan_application]);
    }

    public function show($id)
    {

        $loan = Loan::with('repayment_schedules')->with('transactions')->with('charges')->with('charges.charge_type')->with('charges.charge_option')->with('client')->with('loan_product')->with('notes')->with('guarantors')->with('files')->with('collateral')->with('collateral.collateral_type')->with('history')->with('notes.created_by')->find($id);
        $payments = PaymentDetail::whereIn('transaction_type', ['loan_transaction', 'loan_disbursement'])->where('reference', $id)->orderby('created_at', 'asc')->get();
        $custom_fields = custom_fields_build_data_for_json(CustomField::where('category', 'add_loan')->where('active', 1)->get(), $loan);
        $loan->payments = $payments;
        $loan->custom_fields = $custom_fields;
        return response()->json(['data' => $loan]);
    }


    public function edit($id)
    {

        $loan = Loan::with('repayment_schedules')->with('transactions')->with('charges')->with('client')->with('loan_product')->with('notes')->with('guarantors')->with('files')->with('collateral')->with('collateral.collateral_type')->with('notes.created_by')->find($id);
        $custom_fields = custom_fields_build_data_for_json(CustomField::where('category', 'add_loan')->where('active', 1)->get(), $loan);
        $loan->custom_fields = $custom_fields;
        return response()->json(['data' => $loan]);
    }

    public function update(Request $request, $id)
    {


        $loan_product = LoanProduct::find($request->loan_product_id);
        $loan = Loan::find($id);
        $validator = Validator::make($request->all(), [
            'fund_id' => ['required'],
            'loan_product_id' => ['required'],
            'loan_purpose_id' => ['required'],
            'applied_amount' => ['required', 'numeric'],
            'loan_term' => ['required', 'numeric'],
            'repayment_frequency' => ['required', 'numeric'],
            'repayment_frequency_type' => ['required'],
            'interest_rate' => ['required', 'numeric'],
            'expected_disbursement_date' => ['required', 'date'],
            'loan_officer_id' => ['required'],
            'charges' => ['array'],
            'expected_first_payment_date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan->loan_purpose_id = $request->loan_purpose_id;
            $loan->loan_officer_id = $request->loan_officer_id;
            $loan->expected_disbursement_date = $request->expected_disbursement_date;
            $loan->expected_first_payment_date = $request->expected_first_payment_date;
            $loan->fund_id = $request->fund_id;
            $loan->applied_amount = $request->applied_amount;
            $loan->loan_term = $request->loan_term;
            $loan->repayment_frequency = $request->repayment_frequency;
            $loan->repayment_frequency_type = $request->repayment_frequency_type;
            $loan->interest_rate = $request->interest_rate;
            $loan->interest_rate_type = $loan_product->interest_rate_type;
            $loan->save();
            //save charges
            LoanLinkedCharge::where('loan_id', $id)->delete();
            if (!empty($request->charges)) {
                foreach ($request->charges as $key => $value) {
                    $loan_charge = LoanCharge::find($key);
                    $loan_linked_charge = new LoanLinkedCharge();
                    $loan_linked_charge->loan_id = $loan->id;
                    $loan_linked_charge->name = $loan_charge->name;
                    $loan_linked_charge->loan_charge_id = $key;
                    if ($loan_charge->allow_override == 1) {
                        $loan_linked_charge->amount = $value;
                    } else {
                        $loan_linked_charge->amount = $loan_charge->amount;
                    }
                    $loan_linked_charge->loan_charge_type_id = $loan_charge->loan_charge_type_id;
                    $loan_linked_charge->loan_charge_option_id = $loan_charge->loan_charge_option_id;
                    $loan_linked_charge->is_penalty = $loan_charge->is_penalty;
                    $loan_linked_charge->save();
                }
            }
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

     /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function import_loans(Request $request, $id)
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
            $location = 'uploads/loans'; //Created an "uploads" folder for that
            // Upload file
            $file->move($location, $filename);
            // In case the uploaded file path is to be stored in the database 
            $filepath = public_path($location . "/" . $filename);
            // Reading file
            $file = fopen($filepath, "r");

            // return $filepath;
            // $import = Excel::import(new LoanImport($id), $filepath);

            // return response()->json(['errors'=> $import]);

            if(Excel::import(new LoanImport($id), $filepath))
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
    /*
    * Store a newly created resource in storage.
    * @param Request $request
    * @return Response
    */
   public function import_transactions(Request $request, $id)
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
           $location = 'uploads/transactions'; //Created an "uploads" folder for that
           // Upload file
           $file->move($location, $filename);
           // In case the uploaded file path is to be stored in the database 
           $filepath = public_path($location . "/" . $filename);
           // Reading file
           $file = fopen($filepath, "r");

           // return $filepath;
           $import = Excel::import(new TransactionImport($id), $filepath);

           return response()->json(['message'=> $import]);

           if(Excel::import(new TransactionImport($id), $filepath))
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

    public function approve_loan(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            // 'approved_on_date' => ['required', 'date'],
            'approved_amount' => ['required', 'numeric'],
        ]);

        // return $request;
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan = Loan::find($id);
            $previous_status = $loan->status;
            $loan->approved_by_user_id = Auth::id();
            $loan->approved_amount = $request->approved_amount;
            $loan->approved_on_date = date('Y-m-d');
            $loan->status = 'approved';
            $loan->approved_notes = $request->approved_notes;
            $loan->save();
            $loan_history = new LoanHistory();
            $loan_history->loan_id = $loan->id;
            $loan_history->created_by_id = Auth::id();
            $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
            $loan_history->action = 'Loan Approved';
            $loan_history->save();
            //fire loan status changed event
            event(new LoanStatusChanged($loan, $previous_status));
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_approval(Request $request, $id)
    {

        $loan = Loan::find($id);
        $previous_status = $loan->status;
        $loan->approved_by_user_id = null;
        $loan->approved_amount = null;
        $loan->approved_on_date = null;
        $loan->status = 'submitted';
        $loan->approved_notes = null;
        $loan->save();
        $loan_history = new LoanHistory();
        $loan_history->loan_id = $loan->id;
        $loan_history->created_by_id = Auth::id();
        $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
        $loan_history->action = 'Loan Unapproved';
        $loan_history->save();
        //fire loan status changed event
        event(new LoanStatusChanged($loan, $previous_status));
        return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function reject_loan(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'rejected_notes' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan = Loan::find($id);
            $previous_status = $loan->status;
            $loan->rejected_by_user_id = Auth::id();
            $loan->rejected_on_date = date("Y-m-d");
            $loan->status = 'rejected';
            $loan->rejected_notes = $request->rejected_notes;
            $loan->save();
            $loan_history = new LoanHistory();
            $loan_history->loan_id = $loan->id;
            $loan_history->created_by_id = Auth::id();
            $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
            $loan_history->action = 'Loan Rejected';
            $loan_history->save();
            //fire loan status changed event
            event(new LoanStatusChanged($loan, $previous_status));
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_rejection(Request $request, $id)
    {

        $loan = Loan::find($id);
        $previous_status = $loan->status;
        $loan->rejected_by_user_id = null;
        $loan->rejected_on_date = null;
        $loan->status = 'submitted';
        $loan->rejected_notes = null;
        $loan->save();
        $loan_history = new LoanHistory();
        $loan_history->loan_id = $loan->id;
        $loan_history->created_by_id = Auth::id();
        $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
        $loan_history->action = 'Loan Unrejected';
        $loan_history->save();
        //fire loan status changed event
        event(new LoanStatusChanged($loan, $previous_status));
        return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function withdraw_loan(Request $request, $id)
    {

        $request->validate([
            'withdrawn_notes' => ['required'],
        ]);
        $validator = Validator::make($request->all(), [
            'name' => 'required',
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan = Loan::find($id);
            $previous_status = $loan->status;
            $loan->withdrawn_by_user_id = Auth::id();
            $loan->withdrawn_on_date = date("Y-m-d");
            $loan->status = 'withdrawn';
            $loan->withdrawn_notes = $request->withdrawn_notes;
            $loan->save();
            $loan_history = new LoanHistory();
            $loan_history->loan_id = $loan->id;
            $loan_history->created_by_id = Auth::id();
            $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
            $loan_history->action = 'Loan Withdrawn';
            $loan_history->save();
            //fire loan status changed event
            event(new LoanStatusChanged($loan, $previous_status));
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_withdrawn(Request $request, $id)
    {

        $loan = Loan::find($id);
        $previous_status = $loan->status;
        $loan->withdrawn_by_user_id = null;
        $loan->withdrawn_on_date = null;
        $loan->status = 'submitted';
        $loan->withdrawn_notes = null;
        $loan->save();
        $loan_history = new LoanHistory();
        $loan_history->loan_id = $loan->id;
        $loan_history->created_by_id = Auth::id();
        $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
        $loan_history->action = 'Loan Unwithdrawn';
        $loan_history->save();
        //fire loan status changed event
        event(new LoanStatusChanged($loan, $previous_status));
        return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function write_off_loan(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'written_off_on_date' => ['required'],
            'written_off_notes' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan = Loan::with('repayment_schedules')->find($id);
            $principal = $loan->repayment_schedules->sum('principal') - $loan->repayment_schedules->sum('principal_written_off_derived') - $loan->repayment_schedules->sum('principal_repaid_derived');
            $interest = $loan->repayment_schedules->sum('interest') - $loan->repayment_schedules->sum('interest_written_off_derived') - $loan->repayment_schedules->sum('interest_repaid_derived') - $loan->repayment_schedules->sum('interest_waived_derived');
            $fees = $loan->repayment_schedules->sum('fees') - $loan->repayment_schedules->sum('fees_written_off_derived') - $loan->repayment_schedules->sum('fees_repaid_derived') - $loan->repayment_schedules->sum('fees_waived_derived');
            $penalties = $loan->repayment_schedules->sum('penalties') - $loan->repayment_schedules->sum('penalties_written_off_derived') - $loan->repayment_schedules->sum('penalties_repaid_derived') - $loan->repayment_schedules->sum('penalties_waived_derived');
            $balance = $principal + $interest + $fees + $penalties;
            $previous_status = $loan->status;
            $loan->written_off_by_user_id = Auth::id();
            $loan->written_off_on_date = date("Y-m-d");
            $loan->status = 'written_off';
            $loan->written_off_notes = $request->written_off_notes;
            $loan->save();
            $loan_transaction = new LoanTransaction();
            $loan_transaction->created_by_id = Auth::id();
            $loan_transaction->loan_id = $loan->id;
            $loan_transaction->name = trans_choice('loan::general.write_off', 1);
            $loan_transaction->loan_transaction_type_id = 6;
            $loan_transaction->submitted_on = $loan->written_off_on_date;
            $loan_transaction->created_on = date("Y-m-d");
            $loan_transaction->amount = $balance;
            $loan_transaction->credit = $balance;
            $loan_transaction->save();
            //check if accounting is enabled
            if ($loan->loan_product->accounting_rule == "cash" || $loan->loan_product->accounting_rule == "accrual_periodic" || $loan->loan_product->accounting_rule == "accrual_upfront") {
                //credit account
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->transaction_number = 'L' . $loan_transaction->id;
                $journal_entry->branch_id = $loan->branch_id;
                $journal_entry->currency_id = $loan->currency_id;
                $journal_entry->chart_of_account_id = $loan->loan_product->loan_portfolio_chart_of_account_id;
                $journal_entry->transaction_type = 'loan_write_off';
                $journal_entry->date = $loan->written_off_on_date;
                $date = explode('-', $loan->written_off_on_date);
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
                $journal_entry->credit = $balance;
                $journal_entry->reference = $loan->id;
                $journal_entry->save();
                //debit account
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->transaction_number = 'L' . $loan_transaction->id;
                $journal_entry->branch_id = $loan->branch_id;
                $journal_entry->currency_id = $loan->currency_id;
                $journal_entry->chart_of_account_id = $loan->loan_product->losses_written_off_chart_of_account_id;
                $journal_entry->transaction_type = 'loan_write_off';
                $journal_entry->date = $loan->written_off_on_date;
                $date = explode('-', $loan->written_off_on_date);
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
                $journal_entry->debit = $balance;
                $journal_entry->reference = $loan->id;
                $journal_entry->save();

            }
            $loan_history = new LoanHistory();
            $loan_history->loan_id = $loan->id;
            $loan_history->created_by_id = Auth::id();
            $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
            $loan_history->action = 'Loan Written off';
            $loan_history->save();
            event(new TransactionUpdated($loan));
            //fire loan status changed event
            event(new LoanStatusChanged($loan, $previous_status));
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_write_off(Request $request, $id)
    {

        $loan = Loan::find($id);
        $previous_status = $loan->status;
        $loan->written_off_by_user_id = null;
        $loan->written_off_on_date = null;
        $loan->status = 'active';
        $loan->written_off_notes = null;
        $loan->save();
        foreach (LoanTransaction::where('loan_id', $loan->id)->where('loan_transaction_type_id', 6)->where('reversed', 0)->get() as $key) {
            $key->amount = 0;
            $key->debit = $key->credit;
            $key->reversed = 1;
            $key->save();
        }
        $loan_history = new LoanHistory();
        $loan_history->loan_id = $loan->id;
        $loan_history->created_by_id = Auth::id();
        $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
        $loan_history->action = 'Loan Unwritten off';
        $loan_history->save();
        event(new TransactionUpdated($loan));
        //fire loan status changed event
        event(new LoanStatusChanged($loan, $previous_status));
        return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function change_loan_officer(Request $request, $id)
    {


        $validator = Validator::make($request->all(), [
            'loan_officer_id' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan = Loan::find($id);
            $previous_loan_officer_id = $loan->loan_officer_id;
            $loan->loan_officer_id = $request->loan_officer_id;
            $loan->save();
            if ($previous_loan_officer_id != $request->loan_officer_id) {
                $previous_loan_officer = LoanOfficerHistory::where('loan_id', $loan->id)->where('loan_officer_id', $request->loan_officer_id)->where('end_date', '')->first();
                if (!empty($previous_loan_officer)) {
                    $previous_loan_officer->end_date = date("Y-m-d");
                    $previous_loan_officer->save();
                }
                $loan_officer_history = new LoanOfficerHistory();
                $loan_officer_history->loan_id = $loan->id;
                $loan_officer_history->created_by_id = Auth::id();
                $loan_officer_history->loan_officer_id = $request->loan_officer_id;
                $loan_officer_history->start_date = date("Y-m-d");
                $loan_officer_history->save();
            }
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function disburse_loan(Request $request, $id)
    {

        
        $validator = Validator::make($request->all(), [
            'disbursed_on_date' => ['required', 'date'],
            'first_payment_date' => ['required', 'date', 'after:disbursed_on_date'],
            // 'payment_type_id' => ['required'],
        ]);
        $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;

        // return $request;
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan = Loan::find($id);
            if ($loan->status != 'approved') {
                return response()->json(['data' => $loan, "message" => trans_choice('loan::general.loan', 1) . ' ' . trans_choice('core::general.not', 1) . ' ' . trans_choice('loan::general.approved', 1), "success" => false]);
            }
            //payment details
           
            $previous_status = $loan->status;
            $loan->approved_by_user_id = Auth::id();
            $loan->disbursed_on_date = $request->disbursed_on_date;
            $loan->first_payment_date = $request->first_payment_date;
            $loan->principal = $loan->approved_amount;
            $loan->status = 'active';

            //prepare loan schedule
            //determine interest rate
            $interest_rate = determine_period_interest_rate($loan->interest_rate, $loan->repayment_frequency_type, $loan->interest_rate_type);
            $balance = round($loan->principal, $loan->decimals);
            $period = ($loan->loan_term / $loan->repayment_frequency);
            $payment_from_date = $request->disbursed_on_date;
            $next_payment_date = $request->first_payment_date;
            $total_principal = 0;
            $total_interest = 0;

            for ($i = 1; $i <= 1; $i++) {
                $loan_repayment_schedule = new LoanRepaymentSchedule();
                $loan_repayment_schedule->created_by_id = Auth::id();
                $loan_repayment_schedule->loan_id = $loan->id;
                $loan_repayment_schedule->installment = $i;
                $loan_repayment_schedule->due_date = $next_payment_date;
                $loan_repayment_schedule->from_date = $payment_from_date;
                $date = explode('-', $next_payment_date);
                $loan_repayment_schedule->month = $date[1];
                $loan_repayment_schedule->year = $date[0];
                //determine which method to use
                //flat  method
                if ($loan->interest_methodology == 'flat') {
                    $principal = round($loan->principal / $period, $loan->decimals);
                    $interest = round($interest_rate * $loan->principal, $loan->decimals);
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_repayment_schedule->interest = 0;
                    } else {
                        $loan_repayment_schedule->interest = $interest;
                    }
                    if ($i == $period) {
                        //account for values lost during rounding
                        $loan_repayment_schedule->principal = round($balance, $loan->decimals);
                    } else {
                        $loan_repayment_schedule->principal = $principal;
                    }
                    //determine next balance
                    $balance = ($balance - $principal);
                }
                //reducing balance
                if ($loan->interest_methodology == 'declining_balance') {
                    if ($loan->amortization_method == 'equal_installments') {
                        $amortized_payment = round(determine_amortized_payment($interest_rate, $loan->principal, 1), $loan->decimals);
                        //determine if we have grace period for interest
                        $interest = round($interest_rate * $balance, $loan->decimals);
                        $principal = round(($amortized_payment - $interest), $loan->decimals);
                        if ($loan->grace_on_interest_charged >= $i) {
                            $loan_repayment_schedule->interest = 0;
                        } else {
                            $loan_repayment_schedule->interest = $interest;
                        }
                        if ($i == $period) {
                            //account for values lost during rounding
                            $loan_repayment_schedule->principal = round($balance, $loan->decimals);
                        } else {
                            $loan_repayment_schedule->principal = $principal;
                        }
                        //determine next balance
                        $balance = ($balance - $principal);
                    }
                    if ($loan->amortization_method == 'equal_principal_payments') {
                        $principal = round($loan->principal / $period, $loan->decimals);
                        //determine if we have grace period for interest
                        $interest = round($interest_rate * $balance, $loan->decimals);
                        if ($loan->grace_on_interest_charged >= $i) {
                            $loan_repayment_schedule->interest = 0;
                        } else {
                            $loan_repayment_schedule->interest = $interest;
                        }
                        if ($i == $period) {
                            //account for values lost during rounding
                            $loan_repayment_schedule->principal = round($balance, $loan->decimals);
                        } else {
                            $loan_repayment_schedule->principal = $principal;
                        }
                        //determine next balance
                        $balance = ($balance - $principal);
                    }

                }
                $payment_from_date = Carbon::parse($next_payment_date)->add(1, 'day')->format("Y-m-d");
                $next_payment_date = Carbon::parse($next_payment_date)->add($loan->repayment_frequency, $loan->repayment_frequency_type)->format("Y-m-d");
                $total_principal = $total_principal + $loan_repayment_schedule->principal;
                $total_interest = $total_interest + $loan_repayment_schedule->interest;
                $loan_repayment_schedule->total_due = $loan_repayment_schedule->principal + $loan_repayment_schedule->interest;
                $loan_repayment_schedule->principal_balance = $loan->approved_amount;
                $loan_repayment_schedule->save();
            }
            $loan->expected_maturity_date = $next_payment_date;
            $loan->principal_disbursed_derived = $total_principal;
            $loan->interest_disbursed_derived = $total_interest;

            $loan_history = new LoanHistory();
            $loan_history->loan_id = $loan->id;
            $loan_history->created_by_id = Auth::id();
            $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
            $loan_history->action = 'Loan Disbursed';
            $loan_history->save();

            foreach($request->modes as $mode)
            {
                $payment_detail = new PaymentDetail();
                $payment_detail->created_by_id = Auth::id();
                $payment_detail->payment_type_id = $mode['payment_type_id'];
                $payment_detail->amount = $mode['amount'];
                $payment_detail->register_id = $reg_id;
                $payment_detail->group_id = $loan->group_id;
                $payment_detail->branch_id = $loan->branch_id;
                $payment_detail->transaction_type = 'loan_disbursement';
                $payment_detail->reference = $loan->id;
                $payment_detail->cheque_number = $request->cheque_number;
                $payment_detail->receipt = $mode['receipt'];
                $payment_detail->account_number = $request->account_number;
                $payment_detail->bank_name = $request->bank_name;
                $payment_detail->routing_code = $request->routing_code;
                $payment_detail->save();

                //add disbursal transaction
                $loan_transaction = new LoanTransaction();
                $loan_transaction->created_by_id = Auth::id();
                $loan_transaction->loan_id = $loan->id;
                $loan_transaction->branch_id = $loan->branch_id;
                $loan_transaction->group_id = $loan->group_id;
                $loan_transaction->register_id = $reg_id;
                $loan_transaction->payment_detail_id = $payment_detail->id;
                $loan_transaction->name = trans_choice('loan::general.disbursement', 1);
                $loan_transaction->loan_transaction_type_id = 1;
                $loan_transaction->submitted_on = $loan->disbursed_on_date;
                $loan_transaction->created_on = date("Y-m-d");
                $loan_transaction->amount = $mode['amount'];
                $loan_transaction->debit = $mode['amount'];
                $disbursal_transaction_id = $loan_transaction->id;
                $loan_transaction->save();
            }
            //add interest transaction
            $loan_transaction = new LoanTransaction();
            $loan_transaction->created_by_id = Auth::id();
            $loan_transaction->loan_id = $loan->id;
            $loan_transaction->branch_id = $loan->branch_id;
            $loan_transaction->group_id = $loan->group_id;
            $loan_transaction->register_id = $reg_id;
            $loan_transaction->name = trans_choice('loan::general.interest', 1) . ' ' . $loan_transaction->name = trans_choice('loan::general.applied', 1);
            $loan_transaction->loan_transaction_type_id = 11;
            $loan_transaction->submitted_on = $loan->disbursed_on_date;
            $loan_transaction->created_on = date("Y-m-d");
            $loan_transaction->amount = $total_interest;
            $loan_transaction->debit = $total_interest;
            $loan_transaction->save();
            $installment_fees = 0;
            $disbursement_fees = 0;
            foreach ($loan->charges as $key) {
                //disbursement
                if ($key->loan_charge_type_id == 1) {
                    if ($key->loan_charge_option_id == 1) {
                        $key->calculated_amount = $key->amount;
                        $key->amount_paid_derived = $key->calculated_amount;
                        $key->is_paid = 1;
                        $disbursement_fees = $disbursement_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 2) {
                        $key->calculated_amount = round(($key->amount * $total_principal / 100), $loan->decimals);
                        $key->amount_paid_derived = $key->calculated_amount;
                        $key->is_paid = 1;
                        $disbursement_fees = $disbursement_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 3) {
                        $key->calculated_amount = round(($key->amount * ($total_interest + $total_principal) / 100), $loan->decimals);
                        $key->amount_paid_derived = $key->calculated_amount;
                        $key->is_paid = 1;
                        $disbursement_fees = $disbursement_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 4) {
                        $key->calculated_amount = round(($key->amount * $total_interest / 100), $loan->decimals);
                        $key->amount_paid_derived = $key->calculated_amount;
                        $key->is_paid = 1;
                        $disbursement_fees = $disbursement_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 5) {
                        $key->calculated_amount = round(($key->amount * $total_principal / 100), $loan->decimals);
                        $key->amount_paid_derived = $key->calculated_amount;
                        $key->is_paid = 1;
                        $disbursement_fees = $disbursement_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 6) {
                        $key->calculated_amount = round(($key->amount * $total_principal / 100), $loan->decimals);
                        $key->amount_paid_derived = $key->calculated_amount;
                        $key->is_paid = 1;
                        $disbursement_fees = $disbursement_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 7) {
                        $key->calculated_amount = round(($key->amount * $loan->principal / 100), $loan->decimals);
                        $key->amount_paid_derived = $key->calculated_amount;
                        $key->is_paid = 1;
                        $disbursement_fees = $disbursement_fees + $key->calculated_amount;
                    }
                }
                //installment_fee
                if ($key->loan_charge_type_id == 3) {
                    if ($key->loan_charge_option_id == 1) {
                        $key->calculated_amount = $key->amount;
                        $installment_fees = $installment_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 2) {
                        $key->calculated_amount = round(($key->amount * $total_principal / 100), $loan->decimals);
                        $installment_fees = $installment_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 3) {
                        $key->calculated_amount = round(($key->amount * ($total_interest + $total_principal) / 100), $loan->decimals);
                        $installment_fees = $installment_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 4) {
                        $key->calculated_amount = round(($key->amount * $total_interest / 100), $loan->decimals);
                        $installment_fees = $installment_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 5) {
                        $key->calculated_amount = round(($key->amount * $total_principal / 100), $loan->decimals);
                        $installment_fees = $installment_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 6) {
                        $key->calculated_amount = round(($key->amount * $total_principal / 100), $loan->decimals);
                        $installment_fees = $installment_fees + $key->calculated_amount;
                    }
                    if ($key->loan_charge_option_id == 7) {
                        $key->calculated_amount = round(($key->amount * $loan->principal / 100), $loan->decimals);
                        $installment_fees = $installment_fees + $key->calculated_amount;
                    }
                    //create transaction
                    $loan_transaction = new LoanTransaction();
                    $loan_transaction->created_by_id = Auth::id();
                    $loan_transaction->loan_id = $loan->id;
                    $loan_transaction->branch_id = $loan->branch_id;
                    $loan_transaction->group_id = $loan->group_id;
                    $loan_transaction->register_id = $reg_id;
                    $loan_transaction->name = trans_choice('loan::general.fee', 1) . ' ' . $loan_transaction->name = trans_choice('loan::general.applied', 1);
                    $loan_transaction->loan_transaction_type_id = 10;
                    $loan_transaction->submitted_on = $loan->disbursed_on_date;
                    $loan_transaction->created_on = date("Y-m-d");
                    $loan_transaction->amount = $key->calculated_amount;
                    $loan_transaction->debit = $key->calculated_amount;
                    $loan_transaction->reversible = 1;
                    $loan_transaction->save();
                    $key->loan_transaction_id = $loan_transaction->id;
                    $key->save();
                    //add the charges to the schedule
                    foreach ($loan->repayment_schedules as $loan_repayment_schedule) {
                        if ($key->loan_charge_option_id == 2) {
                            $loan_repayment_schedule->fees = $loan_repayment_schedule->fees + round(($key->amount * $loan_repayment_schedule->principal / 100), $loan->decimals);
                        } elseif ($key->loan_charge_option_id == 3) {
                            $loan_repayment_schedule->fees = $loan_repayment_schedule->fees + round(($key->amount * ($loan_repayment_schedule->interest + $loan_repayment_schedule->principal) / 100), $loan->decimals);
                        } elseif ($key->loan_charge_option_id == 4) {
                            $loan_repayment_schedule->fees = $loan_repayment_schedule->fees + round(($key->amount * $loan_repayment_schedule->interest / 100), $loan->decimals);
                        } else {
                            $loan_repayment_schedule->fees = $loan_repayment_schedule->fees + $key->calculated_amount;
                        }
                        $loan_repayment_schedule->total_due = $loan_repayment_schedule->principal + $loan_repayment_schedule->interest + $loan_repayment_schedule->fees;
                        $loan_repayment_schedule->save();
                    }
                }

            }
            if ($disbursement_fees > 0) {
                $loan_transaction = new LoanTransaction();
                $loan_transaction->created_by_id = Auth::id();
                $loan_transaction->loan_id = $loan->id;
                $loan_transaction->branch_id = $loan->branch_id;
                $loan_transaction->group_id = $loan->group_id;
                $loan_transaction->register_id = $reg_id;
                $loan_transaction->name = trans_choice('loan::general.disbursement', 1) . ' ' . $loan_transaction->name = trans_choice('loan::general.charge', 2);
                $loan_transaction->loan_transaction_type_id = 5;
                $loan_transaction->submitted_on = $loan->disbursed_on_date;
                $loan_transaction->created_on = date("Y-m-d");
                $loan_transaction->amount = ceil($disbursement_fees / 10)*10;
                $loan_transaction->credit = ceil($disbursement_fees / 10)*10;
                $loan_transaction->fees_repaid_derived = ceil($disbursement_fees / 10)*10;
                $loan_transaction->save();
                $disbursement_fees_transaction_id = $loan_transaction->id;
            }
            $loan->disbursement_charges = ceil($disbursement_fees / 10) * 10;
            $loan->save();
            //check if accounting is enabled
            if ($loan->loan_product->accounting_rule == "cash" || $loan->loan_product->accounting_rule == "accrual_periodic" || $loan->loan_product->accounting_rule == "accrual_upfront") {
                //loan disbursal
                //credit account
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->payment_detail_id = '';
                $journal_entry->transaction_number = 'L' . $loan->id;
                $journal_entry->branch_id = $loan->branch_id;
                $journal_entry->currency_id = $loan->currency_id;
                if(PaymentType::find($payment_detail->payment_type_id)->is_cash == 1)
                {
                    $journal_entry->chart_of_account_id = User::find(Auth::id())->user_control_account;
                }
                else{
                    $journal_entry->chart_of_account_id = PaymentType::find($payment_detail->payment_type_id)->asset_control_account;
                }
                $journal_entry->transaction_type = 'loan_disbursement';
                $journal_entry->date = $loan->disbursed_on_date;
                $date = explode('-', $loan->disbursed_on_date);
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
                $journal_entry->credit = $loan->principal;
                $journal_entry->reference = $loan->id;
                $journal_entry->save();
                //debit account
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->transaction_number = 'L' . $loan->id;
                $journal_entry->payment_detail_id = $payment_detail->id;
                $journal_entry->branch_id = $loan->branch_id;
                $journal_entry->currency_id = $loan->currency_id;
                $journal_entry->chart_of_account_id = $loan->loan_product->loan_portfolio_chart_of_account_id;
                $journal_entry->transaction_type = 'loan_disbursement';
                $journal_entry->date = $loan->disbursed_on_date;
                $date = explode('-', $loan->disbursed_on_date);
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
                $journal_entry->debit = $loan->principal;
                $journal_entry->reference = $loan->id;
                $journal_entry->save();
                //
                if ($disbursement_fees > 0) {
                    //credit account
                    $journal_entry = new JournalEntry();
                    $journal_entry->created_by_id = Auth::id();
                    $journal_entry->payment_detail_id = $payment_detail->id;
                    $journal_entry->transaction_number = 'L' . $disbursement_fees_transaction_id;
                    $journal_entry->branch_id = $loan->branch_id;
                    $journal_entry->currency_id = $loan->currency_id;
                    $journal_entry->chart_of_account_id = $loan->loan_product->income_from_fees_chart_of_account_id;
                    $journal_entry->transaction_type = 'repayment_at_disbursement';
                    $journal_entry->date = $loan->disbursed_on_date;
                    $date = explode('-', $loan->disbursed_on_date);
                    $journal_entry->month = $date[1];
                    $journal_entry->year = $date[0];
                    $journal_entry->credit = ceil($disbursement_fees / 10) * 10;
                    $journal_entry->reference = $loan->id;
                    $journal_entry->save();
                    //debit account
                    $journal_entry = new JournalEntry();
                    $journal_entry->created_by_id = Auth::id();
                    $journal_entry->transaction_number = 'L' . $disbursement_fees_transaction_id;
                    $journal_entry->payment_detail_id = $payment_detail->id;
                    $journal_entry->branch_id = $loan->branch_id;
                    $journal_entry->currency_id = $loan->currency_id;
                    if(PaymentType::find($payment_detail->payment_type_id)->is_cash == 1)
                    {
                        $journal_entry->chart_of_account_id = User::find(Auth::id())->user_control_account;
                    }
                    else{
                        $journal_entry->chart_of_account_id = PaymentType::find($payment_detail->payment_type_id)->asset_control_account;
                        // $journal_entry->chart_of_account_id = $loan->loan_product->fund_source_chart_of_account_id;
                    }
                    $journal_entry->transaction_type = 'repayment_at_disbursement';
                    $journal_entry->date = $loan->disbursed_on_date;
                    $date = explode('-', $loan->disbursed_on_date);
                    $journal_entry->month = $date[1];
                    $journal_entry->year = $date[0];
                    $journal_entry->debit = ceil($disbursement_fees / 10) * 10;
                    $journal_entry->reference = $loan->id;
                    $journal_entry->save();
                }
            }
            //fire loan status changed event
            event(new LoanStatusChanged($loan, $previous_status));
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function undo_disbursement(Request $request, $id)
    {

        $loan = Loan::find($id);
        $previous_status = $loan->status;
        $loan->disbursed_by_user_id = null;
        $loan->disbursed_on_date = null;
        $loan->status = 'approved';
        $loan->disbursed_notes = null;
        $loan->save();
        //destroy loan repayment schedules
        LoanLinkedCharge::where('loan_id', $loan->id)->update(["loan_transaction_id" => null]);
        LoanRepaymentSchedule::where('loan_id', $loan->id)->delete();
        LoanTransaction::where('loan_id', $loan->id)->delete();
        PaymentDetail::whereIn('transaction_type', ['loan_transaction', 'loan_disbursement', 'loan_repayment'])->where('reference', $loan->id)->delete();
        // PaymentDetail::where('transaction_type', 'loan_disbursement')->where('reference', $loan->id)->delete();
        
        //reverse journal entries
        JournalEntry::whereIn('transaction_type', ['repayment_at_disbursement', 'loan_disbursement', 'loan_repayment'])->where('reference', $loan->id)->update(["reversed" => 1]);
        $loan_history = new LoanHistory();
        $loan_history->loan_id = $loan->id;
        $loan_history->created_by_id = Auth::id();
        $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
        $loan_history->action = 'Loan Undisbursed';
        $loan_history->save();

        //fire loan status changed event
        event(new LoanStatusChanged($loan, $previous_status));
        return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }


    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        $loan = Loan::find($id);
        $previous_status = $loan->status;
        $loan->disbursed_by_user_id = null;
        $loan->disbursed_on_date = null;
        $loan->status = 'approved';
        $loan->disbursed_notes = null;
        $loan->save();
        //destroy loan repayment schedules
        LoanLinkedCharge::where('loan_id', $loan->id)->delete();
        LoanRepaymentSchedule::where('loan_id', $loan->id)->delete();
        LoanTransaction::where('loan_id', $loan->id)->delete();
        PaymentDetail::whereIn('transaction_type', ['loan_transaction', 'loan_disbursement', 'loan_repayment'])->where('reference', $loan->id)->delete();
        // PaymentDetail::where('transaction_type', 'loan_disbursement')->where('reference', $loan->id)->delete();
        
        //reverse journal entries
        JournalEntry::whereIn('transaction_type', ['repayment_at_disbursement', 'loan_disbursement', 'loan_repayment'])->where('reference', $loan->id)->update(["reversed" => 1]);
        $loan_history = new LoanHistory();
        $loan_history->loan_id = $loan->id;
        $loan_history->created_by_id = Auth::id();
        $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
        $loan_history->action = 'Loan Deleted.';
        $loan_history->save();

        $loan->delete();

        //fire loan status changed event
        // event(new LoanStatusChanged($loan, $previous_status));
        return response()->json(["message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
    }

    //transactions
    public function show_transaction($id)
    {
        $loan_transaction = LoanTransaction::with('payment_detail')->with('loan')->find($id);
        return response()->json(['data' => $loan_transaction]);
    }


    //schedules
    public function email_schedule($id)
    {
        $loan = Loan::with('repayment_schedules')->find($id);
        //return theme_view('loan::loan_schedule.email', compact('loan'));
    }

    public function store_repayment(Request $request, $id)
    {     

        $validator = Validator::make($request->all(), [
            'amount' => "required|array",
            'amount.*.amount' => "required|integer|min:0",
            'amount.*.payment_type_id' => ['required'],
            'date' => ['required']
        ]);
        $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;
        $payment_details = $request->amount; $loans1 = $request->loan_amount; $incomes = $request->income; $savings1 = $request->savings_amount; $temp = array(); $keys = array();
        $balance = array();
        $savings_balance = array();
        $income_balance = array();
        $start = 0; $begin = 0; $total = 0;
        // sort the payments from the highest
        $payments_array = array();
        $loan_payment = array();
        $loans_array = array();  
        $index = 0; 
        
        // return $payment_details;
        $loans = array_filter($loans1, function ($var) {
            return ($var['amount'] != 0);
        });

        $savings = array_filter($savings1, function ($var) {
            return ($var['amount'] != 0);
        });

        usort($payment_details, function($a, $b){ return $a < $b; });
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {

        // LOAN REPAYMENT
        // for($start; $start< count($loans); $start++)
        while($currloans = current($loans))
        {  
            // $index++;
            $current = current($payment_details);    
            // check if the loan has 
            $l = $current['amount'];
            $n = $currloans['amount'];
            $dif = $l - $n;
            // save payment detail with the loan amount
            $min = min([$current['amount'], $currloans['amount']]);  

            $loan = Loan::with('loan_product')->find($currloans['loan_id']);
            
            $schedule = $this->validate_loan_schedule($loan->id);

            // if ($this->validate_repayment($loan->id, $currloans['amount'], $current['receipt']) < 5) {
            //     return response()->json(["success" => false, "message" => 'Update failed. Another similar transaction pending. Try again later.'], 400);
            // } 

            // reject fully paid loans
            if(!empty($schedule))
            {
                
                $amount = $schedule->interest + $schedule->principal - ($schedule->principal_repaid_derived + $schedule->interest_repaid_derived);
                if($currloans['amount'] > $amount)
                {
                    return response()->json(["success" => false, "message" => 'Please review. The repayment amount exceeds the loan balance with Ksh. '. ($current['amount'] - $amount)], 400);   
                }

                if($schedule->total_due == 0)
                {
                    return response()->json(["success" => false, "message" => 'Update failed. The loan total due is 0 and is fully paid.'], 400);
                }
            }

            // else {
            //     return $this->validate_repayment($loan->id, 300, 'HTGHT');    
            // }   
            
            // if($currloans['amount'] > 0){   
               
            // the difference of loan payment and payment received
            // print_r($current);
            
            // ===================FIRST LOAN TRANSACTION ============================
            $payment_detail = new PaymentDetail();
            $payment_detail->created_by_id = Auth::id();
            // $current['payment_type_id]
            $payment_detail->payment_type_id = $current['payment_type_id'];
            $payment_detail->amount = $min;
            $payment_detail->group_id = $request->group_id;
            $payment_detail->branch_id = Group::find($request->group_id)->branch_id;
            $payment_detail->transaction_type = 'loan_transaction';
            $payment_detail->reference = $loan->id;
            $payment_detail->cheque_number = null;
            $payment_detail->payment_date = $request->date;
            //  $current['receipt']
            $payment_detail->receipt = $current['receipt'];
            $payment_detail->register_id = $reg_id;
            $payment_detail->account_number = null;
            $payment_detail->bank_name = null;
            $payment_detail->routing_code = null;
            $payment_detail->save();
            // LOAN TRANSACTION
            $loan_transaction = new LoanTransaction();
            $loan_transaction->created_by_id = Auth::id();
            $loan_transaction->register_id = $reg_id;
            $loan_transaction->group_id = $request->group_id;
            $loan_transaction->created_on = $request->date;
            // $currloans['loan_id']
            $loan_transaction->loan_id = $currloans['loan_id'];
            $loan_transaction->payment_detail_id = $payment_detail->id;
            $loan_transaction->name = trans_choice('loan::general.repayment', 1);
            $loan_transaction->loan_transaction_type_id = 2;
            $loan_transaction->submitted_on = $request->date;
            $loan_transaction->created_on = $request->date;
            // $min
            $loan_transaction->amount = $min;
            $loan_transaction->credit = $min;
            $loan_transaction->save();

            activity()->on($loan_transaction)
                ->withProperties(['id' => $loan_transaction->id])
                ->log('Create Loan Repayment');
            //fire transaction updated event
            event(new TransactionUpdated($loan));

            // 
            // create a new repayment schedule
            if($request->confirm)
            {
                $this->create_repayment_schedule($loan->id, $loan_transaction->amount, $request->date);

            }
            // =================== END OF FIRST LOAN TRANSACTION ================================
            $paid = '1Loan '.array_search($currloans, $loans). ' LOAN ID '.$currloans['loan_id'].' Amount('.$currloans['amount'].') paid with '. $min.' from payment '.$current['amount']. ' Bal: '  .($current['amount'] - $min);
            $balance1 = array('amount'=> $current['amount'], 'payment_type_id'=> $current['payment_type_id'], 'receipt'=>$current['receipt'] );
            array_push($temp, $paid);
            array_push($balance, $balance1);

            // if the loan is fully paid, any amount left from paying this loan is the next payment method
            if($dif > 0){
                // $new_loan = array(['amount' => 0, 'loan_id'=>$currloans['loan_id']]);
                $pos = array_search($current, $payment_details);
                $new_pay = array(['amount'=>$dif, 'payment_type_id'=>$current['payment_type_id'], 'receipt'=>$current['receipt']]);
                array_splice($payment_details, $pos+1, 0, $new_pay);
            }
           
            // next($payment_details);
            next($loans);
            $index++;
        }
        $savings_payments = array_udiff($payment_details, $balance, function($ob, $obj){
            return $ob['amount'] - $obj['amount'];
        });
        
        while($currsavings = current($savings))
        {
                    $saving = Savings::with('savings_product')->find($currsavings['id']);
                    // if ($currsavings['amount'] != 0) {
                    $current = current($savings_payments);
                    // the difference of loan payment and payment received
                    // return $current['payment_type_id'] ??= 0;
                    // print_r($savings_payments);
                    $dif = $current['amount'] - $currsavings['amount'];
                    // save payment detail with the loan amount
                    $min = min([$current['amount'], $currsavings['amount']]);
                    //payment details
                    $payment_detail = new PaymentDetail();
                    $payment_detail->created_by_id = Auth::id();
                    $payment_detail->payment_type_id = $current['payment_type_id'];
                    $payment_detail->amount = $min;
                    $payment_detail->group_id = $request->group_id;
                    $payment_detail->branch_id = Group::find($request->group_id)->branch_id;
                    $payment_detail->transaction_type = 'savings_transaction';
                    $payment_detail->reference = $saving->id;
                    $payment_detail->cheque_number = $request->cheque_number;
                    $payment_detail->receipt = $current['receipt'];
                    $payment_detail->payment_date = $request->date;
                    $payment_detail->register_id = $reg_id;
                    $payment_detail->account_number = $request->account_number;
                    $payment_detail->bank_name = $request->bank_name;
                    $payment_detail->routing_code = $request->routing_code;
                    $payment_detail->save();
                    $savings_transaction = new SavingsTransaction();
                    $savings_transaction->created_by_id = Auth::id();
                    $savings_transaction->savings_id = $saving->id;
                    $savings_transaction->branch_id = $saving->branch_id;
                    $savings_transaction->group_id = $request->group_id;
                    $savings_transaction->register_id = $reg_id;
                    $savings_transaction->payment_detail_id = $payment_detail->id;
                    $savings_transaction->name = trans_choice('savings::general.deposit', 1);
                    $savings_transaction->savings_transaction_type_id = 1;
                    $savings_transaction->submitted_on =$request->date;
                    $savings_transaction->created_on = $request->date;
                    $savings_transaction->reversible = 1;
                    $savings_transaction->amount = $min;
                    $savings_transaction->credit = $min;
                    $savings_transaction->save();
                    if ($saving->savings_product->accounting_rule == 'cash') {
                        //debit account
                        $journal_entry = new JournalEntry();
                        $journal_entry->created_by_id = Auth::id();
                        $journal_entry->payment_detail_id = $payment_detail->id;
                        $journal_entry->transaction_number = 'S' . $savings_transaction->id;
                        $journal_entry->branch_id = $saving->branch_id;
                        $journal_entry->currency_id = $saving->currency_id;
                        if(PaymentType::find($current['payment_type_id'])->is_cash == 1)
                        {
                            $journal_entry->chart_of_account_id = Auth::user()->user_control_account;
                        }else{
                            // $journal_entry->chart_of_account_id = $loan->loan_product->loan_repayment_chart_of_account_id;
                            $journal_entry->chart_of_account_id = PaymentType::find($current['payment_type_id'])->asset_control_account;;
                        }
                        $journal_entry->transaction_type = 'savings_deposit';
                        $journal_entry->date = $request->date;
                        $date = explode('-', $request->date);
                        $journal_entry->month = $date[1];
                        $journal_entry->year = $date[0];
                        $journal_entry->debit = $savings_transaction->amount;
                        $journal_entry->reference = $saving->id;
                        $journal_entry->save();
                        //credit account
                        $journal_entry = new JournalEntry();
                        $journal_entry->created_by_id = Auth::id();
                        $journal_entry->transaction_number = 'S' . $savings_transaction->id;
                        $journal_entry->payment_detail_id = $payment_detail->id;
                        $journal_entry->branch_id = $saving->branch_id;
                        $journal_entry->currency_id = $saving->currency_id;
                        $journal_entry->chart_of_account_id = $saving->savings_product->savings_control_chart_of_account_id;
                        $journal_entry->transaction_type = 'savings_deposit';
                        $journal_entry->date = $request->date;
                        $date = explode('-', $request->date);
                        $journal_entry->month = $date[1];
                        $journal_entry->year = $date[0];
                        $journal_entry->credit = $savings_transaction->amount;
                        $journal_entry->reference = $saving->id;
                        $journal_entry->save();
                    }
                    activity()->on($saving)
                        ->withProperties(['id' => $saving->id])
                        ->log('Create Savings Deposit');
                    //fire transaction updated event
                    event(new \Modules\Savings\Events\TransactionUpdated($saving));
                    \flash(trans_choice("core::general.successfully_saved", 1))->success()->important();

                    $paid = '1Savings ' . array_search($currsavings, $savings) . ' SAVINGS ID ' . $currsavings['id'] . ' paid with ' . $min . ' from payment ' . $current['amount'] . ' Bal: '  . ($current['amount'] - $min);
                    $balance1 = array('amount' => $current['amount'], 'payment_type_id' => $current['payment_type_id'], 'receipt' => $current['receipt']);
                    array_push($temp, $paid);
                    array_push($savings_balance, $balance1);
                    // if the savings is fully paid, any amount left from paying this saving is the next payment method
                    if ($dif > 0) {
                        // $new_loan = array(['amount' => 0, 'loan_id'=>$currloans['loan_id']]);
                        $pos = array_search($current, $savings_payments);
                        $new_payment = array(['amount' => $dif, 'payment_type_id' => $current['payment_type_id'], 'receipt' => $current['receipt']]);
                        array_splice($savings_payments, $pos+1, 0, $new_payment);
                    }                   

                next($savings_payments);
                next($savings);
        }

        $income_payments = array_udiff($savings_payments, $savings_balance, function ($ob, $obj) {
            return $ob['amount'] - $obj['amount'];
        });
        // usort($income_payments, function ($a, $b) {
        //     return $a < $b;
        // });
        // return $income_payments;
        // INCOME TRANSACTIONS
        while($currincome = current($incomes))
        {
                // if ($currincome['amount'] != 0) {
                    $current = current($income_payments);
                    // the difference of loan payment and payment received
                    $dif = $current['amount'] - $currincome['amount'];
                    // save payment detail with the loan amount
                    $min = min([$current['amount'], $currincome['amount']]);

                    // CREATE NEW INCOME
                    $income = new Income();
                    $income->created_by_id = Auth::id();
                    $income->income_type_id = $currincome['income_type_id'];
                    $income->currency_id = 3;
                    $income->branch_id = Group::find($request->group_id)->branch_id;
                    $income->group_id = $request->group_id;
                    $income->register_id = $reg_id;
                    $income->income_chart_of_account_id = IncomeType::find($currincome['income_type_id'])->income_chart_of_account_id;
                    $income->asset_chart_of_account_id = IncomeType::find($currincome['income_type_id'])->asset_chart_of_account_id;
                    $income->amount = $min;
                    $income->date = $request->date;
                    $income->description = IncomeType::find($currincome['income_type_id'])->name;
                    $income->save();

                    // CAPTURE INCOME PAYMENT DETAILS
                    $payment_detail = new PaymentDetail();
                    $payment_detail->created_by_id = Auth::id();
                    $payment_detail->payment_type_id = $current['payment_type_id'];
                    $payment_detail->amount = $min;
                    $payment_detail->group_id = $request->group_id;
                    $payment_detail->branch_id = Group::find($request->group_id)->branch_id;
                    $payment_detail->payment_date = $request->date;
                    $payment_detail->register_id = $reg_id;
                    $payment_detail->transaction_type = 'income';
                    $payment_detail->reference = $income->id;
                    $payment_detail->cheque_number = $request->cheque_number;
                    $payment_detail->receipt = $current['receipt'];
                    $payment_detail->account_number = $request->account_number;
                    $payment_detail->bank_name = $request->bank_name;
                    $payment_detail->routing_code = $request->routing_code;
                    $payment_detail->save();

                    // debit
                    if (!empty($income->income_chart_of_account_id)) {
                        $journal_entry = new JournalEntry();
                        $journal_entry->created_by_id = Auth::id();
                        $journal_entry->payment_detail_id = $payment_detail->id;
                        $journal_entry->transaction_number = $income->id;
                        $journal_entry->branch_id = $income->branch_id;
                        // $journal_entry->group_id = $income->group_id;
                        $journal_entry->currency_id = $income->currency_id;
                        if(PaymentType::find($current['payment_type_id'])->is_cash == 1)
                        {
                            $journal_entry->chart_of_account_id = Auth::user()->user_control_account;
                        }else{
                            // $journal_entry->chart_of_account_id = $loan->loan_product->loan_repayment_chart_of_account_id;
                            $journal_entry->chart_of_account_id = PaymentType::find($current['payment_type_id'])->asset_control_account;
                        }
                        $journal_entry->transaction_type = 'income';
                        $journal_entry->date = $request->date;
                        $date = explode('-', $request->date);
                        $journal_entry->month = $date[1];
                        $journal_entry->year = $date[0];
                        $journal_entry->debit = $income->amount;
                        $journal_entry->reference = $income->id;
                        $journal_entry->notes = $request->notes;
                        $journal_entry->save();
                    }
                    // credit
                    if (!empty($income->asset_chart_of_account_id)) {
                        $journal_entry = new JournalEntry();
                        $journal_entry->created_by_id = Auth::id();
                        $journal_entry->payment_detail_id = $payment_detail->id;
                        $journal_entry->transaction_number = $income->id;
                        $journal_entry->branch_id = $income->branch_id;
                        // $journal_entry->group_id = $income->group_id;
                        $journal_entry->currency_id = $income->currency_id;
                        $journal_entry->chart_of_account_id = $income->income_chart_of_account_id;
                        $journal_entry->transaction_type = 'income';
                        $journal_entry->date = $request->date;;
                        $date = explode('-', $request->date);
                        $journal_entry->month = $date[1];
                        $journal_entry->year = $date[0];
                        $journal_entry->credit = $income->amount;
                        $journal_entry->reference = $income->id;
                        $journal_entry->notes = $income->notes;
                        $journal_entry->save();
                    }

                    $paid = '1Income ' . array_search($currincome, $incomes) . ' INCOME ID ' . $currincome['income_type_id'] . ' paid with ' . $min . ' from payment ' . $current['amount'] . ' Bal: '  . ($current['amount'] - $min);
                    $balance1 = array('amount' => $current['amount'], 'payment_type_id' => $current['payment_type_id'], 'receipt' => $current['receipt']);
                    array_push($temp, $paid);
                    array_push($income_balance, $balance1);

                    // if the income is fully settled, any amount left from settling the income is the next payment method
                    if ($dif > 0) {
                        // $new_loan = array(['amount' => 0, 'loan_id'=>$currloans['loan_id']]);
                        $pos = array_search($current, $income_payments);
                        $new_payment = array(['amount' => $dif, 'payment_type_id' => $current['payment_type_id'], 'receipt' => $current['receipt']]);
                        array_splice($income_payments, $pos + 1, 0, $new_payment);
                    }                   

                next($income_payments);
                next($incomes);
        }

            $income_balance = array_udiff($income_payments, $income_balance, function ($ob, $obj) {
                return $ob['amount'] - $obj['amount'];
            });

            // return $income_balance;

            // return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true, "payment_details" => $savings_payments]);
            return ['temp' => $temp, 'loans' => $loans, 'loan_payments' => $payment_details, 'loan_balance' => $balance, 'savings_payment' => $savings_payments, 'savings_balance' => $savings_balance, 'income_payments'=>$income_payments, 'income_balance'=>$income_balance];
        // return $savings_balance;
            // return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true, "payment_details" => $savings_payments]);
        }
        // end the else statement
    }


    public function create_repayment_schedule($loan_id, $amount_repaid, $date)
    {
        // */
        // get the loan product id
        $loan = Loan::find($loan_id);
        $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;
        // get the current repayment schedule
        $latest_schedule = DB::table('loan_repayment_schedules')->where('loan_id', $loan_id)->latest()->first();

        //prepare loan schedule
        //determine interest rate
        $interest_rate = determine_period_interest_rate($loan->interest_rate, $loan->repayment_frequency_type, $loan->interest_rate_type,$loan->repayment_frequency);
        $balance = round($loan->principal, $loan->decimals);
        $period = ($loan->loan_term / $loan->repayment_frequency);
        $payment_from_date = Carbon::parse($latest_schedule->due_date)->add(1, 'day')->format("Y-m-d");
        $next_payment_date = Carbon::parse($latest_schedule->due_date)->addMonthsNoOverflow($loan->repayment_frequency)->format("Y-m-d");
        $total_principal = 0;
        $total_interest = 0;
        $previous_status = $loan->status;
        $latest_schedule_month = Carbon::parse($latest_schedule->from_date)->month;
        $txn_month = Carbon::parse($date)->month;

        //the current loan is totally repaid within it's time
        // create another schedule for a loan that's not overdue
        if($latest_schedule->total_due <= 0 && $latest_schedule->due_date >= $date)
        {
            // for ($i = 1; $i <= $period; $i++) {
            // create another repayment schedule
            for ($i = 1; $i <= 1; $i++) {
                $loan_repayment_schedule = new LoanRepaymentSchedule();
                $loan_repayment_schedule->created_by_id = Auth::id();
                $loan_repayment_schedule->loan_id = $loan->id;
                $loan_repayment_schedule->installment = $latest_schedule->installment + 1;
                $loan_repayment_schedule->due_date = $next_payment_date;
                $loan_repayment_schedule->from_date = $payment_from_date;
                $date = explode('-', $next_payment_date);
                $loan_repayment_schedule->month = $date[1];
                $loan_repayment_schedule->year = $date[0];
                //determine which method to use
                //flat  method
                // if ($loan->interest_methodology == 'flat') {
                //     $principal = round($loan->principal / $period, $loan->decimals);
                //     $interest = round($interest_rate * $loan->principal, $loan->decimals);
                //     if ($loan->grace_on_interest_charged >= $i) {
                //         $loan_repayment_schedule->interest = 0;
                //     } else {
                //         $loan_repayment_schedule->interest = $interest;
                //     }
                //     if ($i == $period) {
                //         //account for values lost during rounding
                //         $loan_repayment_schedule->principal = round($balance, $loan->decimals);
                //     } else {
                //         $loan_repayment_schedule->principal = $principal;
                //     }
                //     //determine next balance
                //     $balance = ($balance - $principal);
                // }
                //reducing balance
                if ($loan->interest_methodology == 'declining_balance') {
                    if ($loan->amortization_method == 'equal_installments') {
                        if($period == $latest_schedule->installment )
                        {
                            $period = 1;
                        }else{
                            $period = $period - $latest_schedule->installment;
                        }
                        $amortized_payment = round(determine_amortized_payment($interest_rate, ($latest_schedule->principal_balance - $latest_schedule->principal_repaid_derived), 1), $loan->decimals);
                        //determine if we have grace period for interest
                        $interest = round($interest_rate * ($latest_schedule->principal_balance - $latest_schedule->principal_repaid_derived), $loan->decimals);
                        $principal = round(($amortized_payment - $interest), $loan->decimals);
                        if ($loan->grace_on_interest_charged >= $i) {
                            $loan_repayment_schedule->interest = 0;
                        } else {
                            $loan_repayment_schedule->interest = $interest;
                        }
                        if ($i == $period) {
                            //account for values lost during rounding
                            $loan_repayment_schedule->principal = max(round($principal, $loan->decimals), 0);
                        } else {
                            $loan_repayment_schedule->principal = max($principal, 0);
                        }
                        //determine next balance
                        $balance = ($balance - $principal);
                    }
                    // if ($loan->amortization_method == 'equal_principal_payments') {
                    //     $principal = round($loan->principal / $period, $loan->decimals);
                    //     //determine if we have grace period for interest
                    //     $interest = round($interest_rate * $balance, $loan->decimals);
                    //     if ($loan->grace_on_interest_charged >= $i) {
                    //         $loan_repayment_schedule->interest = 0;
                    //     } else {
                    //         $loan_repayment_schedule->interest = $interest;
                    //     }
                    //     if ($i == $period) {
                    //         //account for values lost during rounding
                    //         $loan_repayment_schedule->principal = round($balance, $loan->decimals);
                    //     } else {
                    //         $loan_repayment_schedule->principal = $principal;
                    //     }
                    //     //determine next balance
                    //     $balance = ($balance - $principal);
                    // }

                }

                $payment_from_date = Carbon::parse($next_payment_date)->add(1, 'day')->format("Y-m-d");
                if($loan->repayment_frequency_type=='months'){
                    $next_payment_date = Carbon::parse($next_payment_date)->addMonthsNoOverflow($loan->repayment_frequency)->format("Y-m-d");
                }else{
                    $next_payment_date = Carbon::parse($next_payment_date)->add($loan->repayment_frequency, $loan->repayment_frequency_type)->format("Y-m-d");
                }
                $total_principal = $total_principal + $loan_repayment_schedule->principal;
                $total_interest = $total_interest + $loan_repayment_schedule->interest;
                $loan_repayment_schedule->total_due = $loan_repayment_schedule->principal + $loan_repayment_schedule->interest + ($latest_schedule->principal - $latest_schedule->principal_repaid_derived);
                $loan_repayment_schedule->principal_balance = $latest_schedule->principal_balance - $latest_schedule->principal_repaid_derived;
                $loan_repayment_schedule->save();
                
            }
            
        }
        // if the loan is overdue and (the total owed is more than zero and the date is passed)
        // else if($latest_schedule->total_due >= 0 && $latest_schedule->due_date < date("Y-m-d") && $latest_schedule_month != $txn_month )
        // else if($latest_schedule->total_due >= 0 && $latest_schedule->due_date > $date)
        else if($latest_schedule->total_due >= 0)
        {
            // check if there is a new transaction within this register
            //1. create a new schedule
            for ($i = 1; $i <= 1; $i++) {
                $loan_repayment_schedule = new LoanRepaymentSchedule();
                $loan_repayment_schedule->created_by_id = Auth::id();
                $loan_repayment_schedule->loan_id = $loan->id;
                $loan_repayment_schedule->installment = $latest_schedule->installment + 1;
                $loan_repayment_schedule->due_date = $next_payment_date;
                $loan_repayment_schedule->from_date = $payment_from_date;
                $date = explode('-', $next_payment_date);
                $loan_repayment_schedule->month = $date[1];
                $loan_repayment_schedule->year = $date[0];
                //determine which method to use

                //flat  method
                if ($loan->interest_methodology == 'flat') {
                    // new PRINCIPAL = current principal plus principal from the previous schedule
                    $principal = round($loan->principal / $period, $loan->decimals) + ($latest_schedule->principal - $latest_schedule->principal_repaid_derived);
                    // $principal = $principal + ;
                    $interest = round($interest_rate * $principal, $loan->decimals);
                    if ($loan->grace_on_interest_charged >= $i) {
                        $loan_repayment_schedule->interest = 0;
                    } else {
                        $loan_repayment_schedule->interest = $interest;
                    }
                    if ($i == $period) {
                        //account for values lost during rounding
                        $loan_repayment_schedule->principal = round($principal, $loan->decimals);
                    } else {
                        $loan_repayment_schedule->principal = $principal;
                    }
                    //determine next balance
                    $balance = ($balance - $principal);
                }

                //reducing balance
                if ($loan->interest_methodology == 'declining_balance') {
                    if ($loan->amortization_method == 'equal_installments') {
                        if($latest_schedule->installment >= $period )
                        {
                            $period = 1;
                        }else{
                            $period = $period - $latest_schedule->installment;
                        }
                        $amortized_payment = round(determine_amortized_payment($interest_rate, ($latest_schedule->principal_balance - $latest_schedule->principal_repaid_derived), 1), $loan->decimals);
                        // $balance = 
                        //determine if we have grace period for interest
                        $interest = round($interest_rate * ($latest_schedule->principal_balance - $latest_schedule->principal_repaid_derived), $loan->decimals);
                        $principal = round(($amortized_payment - $interest), $loan->decimals);
                        if ($loan->grace_on_interest_charged >= $i) {
                            $loan_repayment_schedule->interest = 0;
                        } else {
                            $loan_repayment_schedule->interest = $interest;
                        }
                        if ($i == $period) {
                            //account for values lost during rounding
                            $loan_repayment_schedule->principal = max(round($principal, $loan->decimals), 0);
                        } else {
                            $loan_repayment_schedule->principal = max($principal, 0);
                        }
                        //determine next balance
                        $balance = ($balance - $principal);
                    }
                    if ($loan->amortization_method == 'equal_principal_payments') {
                        $principal = round($loan->principal / ($period - $latest_schedule->installment), $loan->decimals) + ($latest_schedule->principal - $latest_schedule->principal_repaid_derived);
                        //determine if we have grace period for interest
                        $interest = round($interest_rate * ($principal), $loan->decimals);
                        if ($loan->grace_on_interest_charged >= $i) {
                            $loan_repayment_schedule->interest = 0;
                        } else {
                            $loan_repayment_schedule->interest = $interest;
                        }
                        if ($i == $period) {
                            //account for values lost during rounding
                            $loan_repayment_schedule->principal = round($principal, $loan->decimals);
                        } else {
                            $loan_repayment_schedule->principal = $principal;
                        }
                        //determine next balance
                        $balance = ($balance - $principal);
                    }

                }
                //2. update the previous schedule balance to amount total repaid.
                $payment_from_date = Carbon::parse($next_payment_date)->add(1, 'day')->format("Y-m-d");
                if($loan->repayment_frequency_type=='months'){
                    $next_payment_date = Carbon::parse($next_payment_date)->addMonthsNoOverflow($loan->repayment_frequency)->format("Y-m-d");
                }else{
                    $next_payment_date = Carbon::parse($next_payment_date)->add($loan->repayment_frequency, $loan->repayment_frequency_type)->format("Y-m-d");
                }
                $total_principal = $total_principal + $loan_repayment_schedule->principal + ($latest_schedule->principal - $latest_schedule->principal_repaid_derived);
                $total_interest = $total_interest + $loan_repayment_schedule->interest;
                $loan_repayment_schedule->total_due = $loan_repayment_schedule->principal + $loan_repayment_schedule->interest + $loan_repayment_schedule->fees + $loan_repayment_schedule->penalties;
                $loan_repayment_schedule->principal_balance = $latest_schedule->principal_balance - $latest_schedule->principal_repaid_derived;
                $loan_repayment_schedule->save();
            }

             // UPDATE THE PREVIOUS REPAYMENT SCHEDULES
            $update_schedule = LoanRepaymentSchedule::find($latest_schedule->id);
            $update_schedule->principal = $latest_schedule->principal_repaid_derived;
            $update_schedule->total_due = 0;
            $update_schedule->paid_by_date = date("Y-m-d");
            $update_schedule->save();

            // //add interest transaction
            // $loan_transaction = new LoanTransaction();
            // $loan_transaction->created_by_id = Auth::id();
            // $loan_transaction->loan_id = $loan->id;
            // $loan_transaction->branch_id = $loan->branch_id;
            // $loan_transaction->group_id = $loan->group_id;
            // $loan_transaction->register_id = $reg_id;
            // $loan_transaction->name = trans_choice('loan::general.interest', 1) . ' ' . $loan_transaction->name = trans_choice('loan::general.applied', 1);
            // $loan_transaction->loan_transaction_type_id = 11;
            // $loan_transaction->submitted_on = $loan->disbursed_on_date;
            // $loan_transaction->created_on = date("Y-m-d");
            // $loan_transaction->amount = $total_interest;
            // $loan_transaction->debit = $total_interest;
            // $loan_transaction->save();

        }

       

        activity()->on($loan)
            ->withProperties(['id' => $loan->id])
            ->log('Repayment Schedule Updated.');
            //fire loan status changed event
            event(new LoanStatusChanged($loan, $previous_status));
            // \flash(trans_choice("core::general.successfully_saved", 1))->success()->important();
            // return redirect('loan/' . $loan->id . '/show');

    }

    public function validate_repayment($loan_id, $amount, $txn_ref)
    {
        $loan = Loan::with('transactions')->find($loan_id);
        $loan_transaction = LoanTransaction::where('loan_id', $loan_id)->where('amount', $amount)->latest()->first();        
        if(!empty($loan_transaction) && $loan_transaction->amount == $amount)
        {
            $created = Carbon::parse($loan_transaction->created_at);
            $updated = Carbon::parse(Carbon::now());
            $duration = $updated->diffInMInutes($created);
            return $duration;
        }
    }


    public function validate_loan_schedule($loan_id)
    {
        // /find the last schedule
        $schedule = LoanRepaymentSchedule::where('loan_id', $loan_id)->latest()->first();

        return $schedule;
    }

    public function update_repayment(Request $request, $id)
    {
        $loan_transaction = LoanTransaction::find($id);
        $loan = $loan_transaction->loan;
        //payment details
        $payment_detail = PaymentDetail::find($loan_transaction->payment_detail_id);
        $validator = Validator::make($request->all(), [
            'amount' => ['required', 'numeric'],
            'date' => ['required', 'date'],
            'payment_type_id' => ['required'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $payment_detail->payment_type_id = $request->payment_type_id;
            $payment_detail->amount = $request->amount;
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->receipt = $request->receipt;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->bank_name = $request->bank_name;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->save();
            $loan_transaction->submitted_on = $request->date;
            $loan_transaction->amount = $request->amount;
            $loan_transaction->credit = $request->amount;
            $loan_transaction->save();
            //fire transaction updated event
            event(new TransactionUpdated($loan));
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function waive_charge(Request $request, $id)
    {

        $loan_linked_charge = LoanLinkedCharge::with('loan')->with('transaction')->find($id);
        $loan_linked_charge->waived = 1;
        $loan_linked_charge->save();
        $loan = $loan_linked_charge->loan;
        $loan_transaction = $loan_linked_charge->transaction;
        $loan_transaction->credit = $loan_transaction->amount;
        $loan_transaction->debit = $loan_transaction->amount;
        $loan_transaction->reversed = 1;
        $loan_transaction->save();
        if ($loan_linked_charge->loan_charge_type_id == 2 || $loan_linked_charge->loan_charge_type_id == 4 || $loan_linked_charge->loan_charge_type_id == 6 || $loan_linked_charge->loan_charge_type_id == 2 || $loan_linked_charge->loan_charge_type_id == 7 || $loan_linked_charge->loan_charge_type_id == 8) {
            $repayment_schedule = LoanRepaymentSchedule::where('loan_id', $loan->id)->where('due_date', $loan_transaction->due_date)->first();
            if ($loan_linked_charge->is_penalty == 1) {
                $repayment_schedule->penalties_waived_derived = $repayment_schedule->penalties_waived_derived + $loan_linked_charge->calculated_amount;
            } else {
                $repayment_schedule->fees_waived_derived = $repayment_schedule->fees_waived_derived + $loan_linked_charge->calculated_amount;
            }
            $repayment_schedule->save();
        }
        if ($loan_linked_charge->loan_charge_type_id == 3) {
            $amount = 0;
            foreach ($loan->repayment_schedules as $repayment_schedule) {
                if ($loan_linked_charge->loan_charge_option_id == 1) {
                    $amount = $loan_linked_charge->calculated_amount;
                }
                if ($loan_linked_charge->loan_charge_option_id == 2) {
                    $amount = round(($loan_linked_charge->amount * $repayment_schedule->principal / 100), $loan->decimals);
                }
                if ($loan_linked_charge->loan_charge_option_id == 3) {
                    $amount = round(($loan_linked_charge->amount * ($repayment_schedule->interest + $repayment_schedule->principal) / 100), $loan->decimals);
                }
                if ($loan_linked_charge->loan_charge_option_id == 4) {
                    $amount = round(($loan_linked_charge->amount * $repayment_schedule->interest / 100), $loan->decimals);
                }
                if ($loan_linked_charge->loan_charge_option_id == 5) {
                    $amount = round(($loan_linked_charge->amount * $loan->principal / 100), $loan->decimals);
                }
                if ($loan_linked_charge->loan_charge_option_id == 6) {
                    $amount = round(($loan_linked_charge->amount * $loan->principal / 100), $loan->decimals);
                }
                if ($loan_linked_charge->loan_charge_option_id == 7) {
                    $amount = round(($loan_linked_charge->amount * $loan->principal / 100), $loan->decimals);
                }
                $repayment_schedule->fees_waived_derived = $repayment_schedule->fees_waived_derived + $amount;
                $repayment_schedule->save();
            }
        }
        //fire transaction updated event
        event(new TransactionUpdated($loan));
        return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }



    public function store_loan_linked_charge(Request $request, $id)
    {
        $loan = Loan::with('repayment_schedules')->find($id);

        $validator = Validator::make($request->all(), [
            'amount' => ['required'],
            'loan_charge_id' => ['required'],
            'date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan_charge = LoanCharge::find($request->loan_charge_id);
            $loan_linked_charge = new LoanLinkedCharge();
            $loan_linked_charge->loan_id = $loan->id;
            $loan_linked_charge->name = $loan_charge->name;
            $loan_linked_charge->loan_charge_id = $loan_charge->id;
            if ($loan_charge->allow_override == 1) {
                $loan_linked_charge->amount = $request->amount;
            } else {
                $loan_linked_charge->amount = $loan_charge->amount;
            }
            $loan_linked_charge->loan_charge_type_id = $loan_charge->loan_charge_type_id;
            $loan_linked_charge->loan_charge_option_id = $loan_charge->loan_charge_option_id;
            $loan_linked_charge->is_penalty = $loan_charge->is_penalty;
            $loan_linked_charge->save();
            //find schedule to apply this charge
            $repayment_schedule = $loan->repayment_schedules->where('due_date', '>=', $request->date)->where('from_date', '<=', $request->date)->first();
            if (empty($repayment_schedule)) {
                if (Carbon::parse($request->date)->lessThan($loan->first_payment_date)) {
                    $repayment_schedule = $loan->repayment_schedules->first();
                } else {
                    $repayment_schedule = $loan->repayment_schedules->last();
                }

            }
            //calculate the amount
            if ($loan_linked_charge->loan_charge_option_id == 1) {
                $amount = $loan_linked_charge->amount;
            }
            if ($loan_linked_charge->loan_charge_option_id == 2) {
                $amount = round(($loan_linked_charge->amount * ($repayment_schedule->principal - $repayment_schedule->principal_repaid_derived - $repayment_schedule->principal_written_off_derived) / 100), $loan->decimals);
            }
            if ($loan_linked_charge->loan_charge_option_id == 3) {
                $amount = round(($loan_linked_charge->amount * (($repayment_schedule->interest - $repayment_schedule->interest_repaid_derived - $repayment_schedule->interest_waived_derived - $repayment_schedule->interest_written_off_derived) + ($repayment_schedule->principal - $repayment_schedule->principal_repaid_derived - $repayment_schedule->principal_written_off_derived)) / 100), $loan->decimals);
            }
            if ($loan_linked_charge->loan_charge_option_id == 4) {
                $amount = round(($loan_linked_charge->amount * ($repayment_schedule->interest - $repayment_schedule->interest_repaid_derived - $repayment_schedule->interest_waived_derived - $repayment_schedule->interest_written_off_derived) / 100), $loan->decimals);
            }
            if ($loan_linked_charge->loan_charge_option_id == 5) {
                $amount = round(($loan_linked_charge->amount * ($loan->repayment_schedules->sum('principal') - $loan->repayment_schedules->sum('principal_repaid_derived') - $loan->repayment_schedules->sum('principal_written_off_derived')) / 100), $loan->decimals);
            }
            if ($loan_linked_charge->loan_charge_option_id == 6) {
                $amount = round(($loan_linked_charge->amount * $loan->principal / 100), $loan->decimals);
            }
            if ($loan_linked_charge->loan_charge_option_id == 7) {
                $amount = round(($loan_linked_charge->amount * $loan->principal / 100), $loan->decimals);
            }
            $repayment_schedule->fees = $repayment_schedule->fees + $amount;
            $repayment_schedule->save();
            $loan_linked_charge->calculated_amount = $amount;
            $loan_linked_charge->due_date = $repayment_schedule->due_date;
            //create transaction
            $loan_transaction = new LoanTransaction();
            $loan_transaction->created_by_id = Auth::id();
            $loan_transaction->loan_id = $loan->id;
            $loan_transaction->group_id = $loan->group_id;
            $loan_transaction->name = trans_choice('loan::general.fee', 1) . ' ' . $loan_transaction->name = trans_choice('loan::general.applied', 1);
            $loan_transaction->loan_transaction_type_id = 10;
            $loan_transaction->submitted_on = $repayment_schedule->due_date;
            $loan_transaction->created_on = date("Y-m-d");
            $loan_transaction->amount = $loan_linked_charge->calculated_amount;
            $loan_transaction->due_date = $repayment_schedule->due_date;
            $loan_transaction->debit = $loan_linked_charge->calculated_amount;
            $loan_transaction->reversible = 1;
            $loan_transaction->save();
            $loan_linked_charge->loan_transaction_id = $loan_transaction->id;
            $loan_linked_charge->save();
            //fire transaction updated event
            event(new TransactionUpdated($loan));
            return response()->json(['data' => $loan_linked_charge, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

        }
    }

    public function waive_interest(Request $request, $id)
    {
        $loan = Loan::with('repayment_schedules')->find($id);

        $validator = Validator::make($request->all(), [
            'interest_waived_amount' => ['required'],
            'date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            //find schedule to apply this charge
            $repayment_schedule = $loan->repayment_schedules->where('due_date', '>=', $request->date)->where('from_date', '<=', $request->date)->first();
            if (empty($repayment_schedule)) {
                if (Carbon::parse($request->date)->lessThan($loan->first_payment_date)) {
                    $repayment_schedule = $loan->repayment_schedules->first();
                } else {
                    $repayment_schedule = $loan->repayment_schedules->last();
                }

            }
            $amount = $request->interest_waived_amount;
            foreach ($loan->repayment_schedules->where('due_date', '>=', $repayment_schedule->due_date) as $repayment_schedule) {
                $interest = $repayment_schedule->interest - $repayment_schedule->interest_written_off_derived - $repayment_schedule->interest_repaid_derived - $repayment_schedule->interest_waived_derived;
                if ($interest <= 0) {
                    continue;
                }
                if ($amount >= $interest) {
                    $repayment_schedule->interest_waived_derived = $repayment_schedule->interest_waived_derived + $interest;
                    $amount = $amount - $interest;
                } else {
                    $repayment_schedule->interest_waived_derived = $repayment_schedule->interest_waived_derived + $amount;
                    $amount = 0;
                }
                $repayment_schedule->save();
                if ($amount <= 0) {
                    break;
                }
            }
            $repayment_schedule->fees = $repayment_schedule->fees + $amount;
            $repayment_schedule->save();
            //create transaction
            $loan_transaction = new LoanTransaction();
            $loan_transaction->created_by_id = Auth::id();
            $loan_transaction->loan_id = $loan->id;
            $loan_transaction->group_id = $loan->group_id;
            $loan_transaction->name = trans_choice('loan::general.waive', 1) . ' ' . $loan_transaction->name = trans_choice('loan::general.interest', 1);
            $loan_transaction->loan_transaction_type_id = 4;
            $loan_transaction->submitted_on = $request->date;
            $loan_transaction->created_on = date("Y-m-d");
            $loan_transaction->amount = $request->interest_waived_amount;
            $loan_transaction->credit = $request->interest_waived_amount;
            $loan_transaction->reversible = 0;
            $loan_transaction->save();
            //fire transaction updated event
            event(new TransactionUpdated($loan));
            return response()->json(['data' => $loan_transaction, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

        }
    }

    public function reverse_repayment(Request $request, $id)
    {

        $loan_transaction = LoanTransaction::find($id);
        $loan = $loan_transaction->loan;

        // return $loan;
        $loan_transaction->amount = 0;
        $loan_transaction->debit = $loan_transaction->credit;
        $loan_transaction->reversed = 1;
        $loan_transaction->save();

        //fire transaction updated event
        $loan2 = $loan_transaction->loan;
        event(new TransactionUpdated($loan2));
        return response()->json(['data' => $loan_transaction, "message" => "Transaction reversal completed successfully.", "success" => true]);

    }


    public function process_loan_calculator(Request $request)
    {
        $loan_product = LoanProduct::with('charges')->with('charges.charge')->find($request->loan_product_id);
        $loan_details = [];
        $loan_details['principal'] = $request->applied_amount;
        $loan_details['disbursement_date'] = $request->expected_disbursement_date;

        $schedules = [];
        $loan_principal = $request->applied_amount;
        $interest_rate = determine_period_interest_rate($request->interest_rate, $request->repayment_frequency_type, $request->interest_rate_type);
        $balance = round($loan_principal, $loan_product->decimals);
        $period = ($request->loan_term / $request->repayment_frequency);
        $payment_from_date = $request->expected_disbursement_date;
        $next_payment_date = $request->expected_first_payment_date;
        $total_principal = 0;
        $total_interest = 0;
        for ($i = 1; $i <= $period; $i++) {
            $schedule = [];

            $schedule['installment'] = $i;
            $schedule['due_date'] = $next_payment_date;
            $schedule['from_date'] = $payment_from_date;
            $schedule['fees'] = 0;

            //flat  method
            if ($loan_product->interest_methodology == 'flat') {
                $principal = round($loan_principal / $period, $loan_product->decimals);
                $interest = round($interest_rate * $loan_principal, $loan_product->decimals);
                if ($loan_product->grace_on_interest_charged >= $i) {
                    $schedule['interest'] = 0;
                } else {
                    $schedule['interest'] = $interest;
                }
                if ($i == $period) {
                    //account for values lost during rounding
                    $schedule['principal'] = round($balance, $loan_product->decimals);
                } else {
                    $schedule['principal'] = $principal;
                }
                //determine next balance
                $balance = ($balance - $principal);
            }
            //reducing balance
            if ($loan_product->interest_methodology == 'declining_balance') {
                if ($loan_product->amortization_method == 'equal_installments') {
                    $amortized_payment = round(determine_amortized_payment($interest_rate, $loan_principal, $period), $loan_product->decimals);
                    //determine if we have grace period for interest
                    $interest = round($interest_rate * $balance, $loan_product->decimals);
                    $principal = round(($amortized_payment - $interest), $loan_product->decimals);
                    if ($loan_product->grace_on_interest_charged >= $i) {
                        $schedule['interest'] = 0;
                    } else {
                        $schedule['interest'] = $interest;
                    }
                    if ($i == $period) {
                        //account for values lost during rounding
                        $schedule['principal'] = round($balance, $loan_product->decimals);
                    } else {
                        $schedule['principal'] = $principal;
                    }
                    //determine next balance
                    $balance = ($balance - $principal);
                }
                if ($loan_product->amortization_method == 'equal_principal_payments') {
                    $principal = round($loan_principal / $period, $loan_product->decimals);
                    //determine if we have grace period for interest
                    $interest = round($interest_rate * $balance, $loan_product->decimals);
                    if ($loan_product->grace_on_interest_charged >= $i) {
                        $schedule['interest'] = 0;
                    } else {
                        $schedule['interest'] = $interest;
                    }
                    if ($i == $period) {
                        //account for values lost during rounding
                        $schedule['principal'] = round($balance, $loan_product->decimals);
                    } else {
                        $schedule['principal'] = $principal;
                    }
                    //determine next balance
                    $balance = ($balance - $principal);
                }

            }
            $payment_from_date = Carbon::parse($next_payment_date)->add(1, 'day')->format("Y-m-d");
            $next_payment_date = Carbon::parse($next_payment_date)->add($loan_product->repayment_frequency, $loan_product->repayment_frequency_type)->format("Y-m-d");
            $total_principal = $total_principal + $schedule['principal'];
            $total_interest = $total_interest + $schedule['interest'];
            array_push($schedules, $schedule);
        }

        $installment_fees = 0;
        $disbursement_fees = 0;
        foreach ($loan_product->charges as $key) {
            //disbursement

            if ($key->charge->loan_charge_type_id == 1) {
                $amount = 0;
                if ($key->charge->loan_charge_option_id == 1) {
                    $amount = $key->charge->amount;

                }
                if ($key->charge->loan_charge_option_id == 2) {
                    $amount = round(($key->charge->amount * $total_principal / 100), $loan_product->decimals);
                }
                if ($key->charge->loan_charge_option_id == 3) {
                    $amount = round(($key->charge->amount * ($total_interest + $total_principal) / 100), $loan_product->decimals);

                }
                if ($key->charge->loan_charge_option_id == 4) {
                    $amount = round(($key->charge->amount * $total_interest / 100), $loan_product->decimals);

                }
                if ($key->charge->loan_charge_option_id == 5) {
                    $amount = round(($key->charge->amount * $total_principal / 100), $loan_product->decimals);

                }
                if ($key->charge->loan_charge_option_id == 6) {
                    $amount = round(($key->charge->amount * $total_principal / 100), $loan_product->decimals);

                }
                if ($key->charge->loan_charge_option_id == 7) {
                    $amount = round(($key->charge->amount * $loan_principal / 100), $loan_product->decimals);

                }
                $disbursement_fees = $disbursement_fees + $amount;
            }
            //installment_fee
            if ($key->charge->loan_charge_type_id == 3) {
                $amount = 0;
                if ($key->charge->loan_charge_option_id == 1) {
                    $amount = $key->charge->amount;
                }
                if ($key->charge->loan_charge_option_id == 2) {
                    $amount = round(($key->charge->amount * $total_principal / 100), $loan_product->decimals);
                }
                if ($key->charge->loan_charge_option_id == 3) {
                    $amount = round(($key->charge->amount * ($total_interest + $total_principal) / 100), $loan_product->decimals);
                }
                if ($key->charge->loan_charge_option_id == 4) {
                    $amount = round(($key->charge->amount * $total_interest / 100), $loan_product->decimals);
                }
                if ($key->charge->loan_charge_option_id == 5) {
                    $amount = round(($key->charge->amount * $total_principal / 100), $loan_product->decimals);
                }
                if ($key->charge->loan_charge_option_id == 6) {
                    $amount = round(($key->charge->amount * $total_principal / 100), $loan_product->decimals);
                }
                if ($key->charge->loan_charge_option_id == 7) {
                    $amount = round(($key->charge->amount * $loan_principal / 100), $loan_product->decimals);
                }
                $installment_fees = $installment_fees + $amount;
                //add the charges to the schedule
                foreach ($schedules as &$temp) {
                    if ($key->charge->loan_charge_option_id == 2) {
                        $temp['fees'] = $temp['fees'] + round(($key->charge->amount * $temp['principal'] / 100), $loan_product->decimals);
                    } elseif ($key->charge->loan_charge_option_id == 3) {
                        $temp['fees'] = $temp['fees'] + round(($key->charge->amount * ($temp['interest'] + $temp['principal']) / 100), $loan_product->decimals);
                    } elseif ($key->charge->loan_charge_option_id == 4) {
                        $temp['fees'] = $temp['fees'] + round(($key->charge->amount * $temp['interest'] / 100), $loan_product->decimals);
                    } else {
                        $temp['fees'] = $temp['fees'] + $key->charge->amount;
                    }

                }

            }

        }
        $loan_details['total_interest'] = $total_interest;
        $loan_details['decimals'] = $loan_product->decimals;
        $loan_details['disbursement_fees'] = $disbursement_fees;
        $loan_details['total_fees'] = $disbursement_fees + $installment_fees;
        $loan_details['total_due'] = $disbursement_fees + $installment_fees + $total_interest + $total_principal;
        $loan_details['maturity_date'] = $next_payment_date;
        return response()->json(['loan_details' => $loan_details, "schedules" => $schedules, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
    }
    public function store_approve_application(Request $request, $id)
    {


        $loan_product = LoanProduct::find($request->loan_product_id);
        $client = Client::find($request->client_id);
        $reg = Register::find(Auth::id())->where('status', 'active')->first();
        $validator = Validator::make($request->all(), [
            'fund_id' => ['required'],
            'loan_product_id' => ['required'],
            'client_id' => ['required'],
            'applied_amount' => ['required', 'numeric'],
            'loan_term' => ['required', 'numeric'],
            'repayment_frequency' => ['required', 'numeric'],
            'repayment_frequency_type' => ['required'],
            'interest_rate' => ['required', 'numeric'],
            'expected_disbursement_date' => ['required', 'date'],
            'loan_officer_id' => ['required'],
            'loan_purpose_id' => ['required'],
            'expected_first_payment_date' => ['required', 'date'],
        ]);
        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else {
            $loan = new Loan();
            $loan->currency_id = $loan_product->currency_id;
            $loan->loan_product_id = $loan_product->id;
            $loan->client_id = $client->id;
            $loan->branch_id = $client->branch_id;
            $loan->group_id = $client->group_id;
            $loan->loan_transaction_processing_strategy_id = $loan_product->loan_transaction_processing_strategy_id;
            $loan->loan_purpose_id = $request->loan_purpose_id;
            $loan->loan_officer_id = $request->loan_officer_id;
            $loan->expected_disbursement_date = $request->expected_disbursement_date;
            $loan->expected_first_payment_date = $request->expected_first_payment_date;
            $loan->fund_id = $request->fund_id;
            $loan->created_by_id = Auth::id();
            $loan->applied_amount = $request->applied_amount;
            $loan->loan_term = $request->loan_term;
            $loan->repayment_frequency = $request->repayment_frequency;
            $loan->repayment_frequency_type = $request->repayment_frequency_type;
            $loan->interest_rate = $request->interest_rate;
            $loan->interest_rate_type = $loan_product->interest_rate_type;
            $loan->grace_on_principal_paid = $loan_product->grace_on_principal_paid;
            $loan->grace_on_interest_paid = $loan_product->grace_on_interest_paid;
            $loan->grace_on_interest_charged = $loan_product->grace_on_interest_charged;
            $loan->interest_methodology = $loan_product->interest_methodology;
            $loan->amortization_method = $loan_product->amortization_method;
            $loan->auto_disburse = $loan_product->auto_disburse;
            $loan->submitted_on_date = date("Y-m-d");
            $loan->submitted_by_user_id = Auth::id();
            $loan->save();
            //save charges
            if (!empty($request->charges)) {
                foreach ($request->charges as $key => $value) {
                    $loan_charge = LoanCharge::find($key);
                    $loan_linked_charge = new LoanLinkedCharge();
                    $loan_linked_charge->loan_id = $loan->id;
                    $loan_linked_charge->name = $loan_charge->name;
                    $loan_linked_charge->loan_charge_id = $key;
                    if ($loan_charge->allow_override == 1) {
                        $loan_linked_charge->amount = $value;
                    } else {
                        $loan_linked_charge->amount = $loan_charge->amount;
                    }
                    $loan_linked_charge->loan_charge_type_id = $loan_charge->loan_charge_type_id;
                    $loan_linked_charge->loan_charge_option_id = $loan_charge->loan_charge_option_id;
                    $loan_linked_charge->is_penalty = $loan_charge->is_penalty;
                    $loan_linked_charge->save();
                }
            }
            $loan_history = new LoanHistory();
            $loan_history->loan_id = $loan->id;
            $loan_history->created_by_id = Auth::id();
            $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
            $loan_history->action = 'Loan Created';
            $loan_history->save();
            $loan_officer_history = new LoanOfficerHistory();
            $loan_officer_history->loan_id = $loan->id;
            $loan_officer_history->created_by_id = Auth::id();
            $loan_officer_history->loan_officer_id = $request->loan_officer_id;
            $loan_officer_history->start_date = date("Y-m-d");
            $loan_officer_history->save();
            //update loan application
            $loan_application = LoanApplication::find($id);
            $loan_application->status = 'approved';
            $loan_application->loan_id = $loan->id;
            $loan_application->save();
            //fire loan status changed event
            event(new LoanStatusChanged($loan));
            return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        }
    }

    public function reject_application(Request $request, $id)
    {

        $loan_application = LoanApplication::find($id);
        $loan_application->status = 'rejected';
        $loan_application->save();
        return response()->json(['data' => $loan_application, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
    }

    public function undo_reject_application(Request $request, $id)
    {

        $loan_application = LoanApplication::find($id);
        $loan_application->status = 'pending';
        $loan_application->save();
        return response()->json(['data' => $loan_application, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);

    }

    public function payment_types()
    {
        $payment_types = PaymentType::select('id', 'name', 'description')->where('active', 1)->get();

        return $payment_types;
    }

}
