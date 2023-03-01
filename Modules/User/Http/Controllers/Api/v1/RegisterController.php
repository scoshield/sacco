<?php

namespace Modules\User\Http\Controllers\Api\v1;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\User\Entities\Register;
use Modules\User\Entities\User;
use Modules\Expense\Entities\Expense;
use Modules\Income\Entities\Income;
use Modules\Loan\Entities\Loan;
use Illuminate\Support\Str;
use Modules\Core\Entities\PaymentDetail;
use Modules\Savings\Entities\Savings;
use Modules\Client\Entities\Group;
use Modules\Loan\Entities\LoanTransaction;
use Illuminate\Support\Facades\Validator;
use Modules\Accounting\Entities\JournalEntry;
// use Modules\Loan\Entities\LoanTransaction;
use Auth;
use Modules\Savings\Entities\SavingsTransaction;
use DB;

class RegisterController extends Controller
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
        $registers = Register::with('user')->with('loan_transactions')->with('savings_transactions')->get();
        return response()->json(['data' => $registers]);
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function initiate_transfer(Request $request, $id)
    {
        // return view('user::create');
        $validator = Validator::make($request->all(), [
            'amount' => ['required', 'integer'],
            'group_id' => ['required','exists:client_groups,id'],
            'register_id' => ['required','exists:registers,id'],
            'date' => ['required', 'date']
        ]);

        if ($validator->fails()) {
            return response()->json(["success" => false, "errors" => $validator->errors()], 400);
        } else{
            //insert a new loans transaction
            //add disbursal transaction
            $from = Group::find($id);
            $to = Group::find($request->group_id);
            $sender = Register::where('user_id', Auth::id())->where('status', 'active')->latest()->first();
            $recipient = Register::find($request->register_id);

            $sending_officer = User::find(Auth::id());
            $recipient_officer = User::find($recipient->user_id);

             $loan_transaction = new LoanTransaction();
             $loan_transaction->created_by_id = Auth::id();
             $loan_transaction->loan_id = 0;
             $loan_transaction->branch_id = $from->branch_id;
             $loan_transaction->group_id = $from->id;
             $loan_transaction->register_id = $sender->id;
             $loan_transaction->payment_detail_id = '';
             $loan_transaction->name = 'Funds Transfer';
             $loan_transaction->loan_transaction_type_id = 3;
             $loan_transaction->submitted_on = $request->date;
             $loan_transaction->created_on = $request->date;
             $loan_transaction->status = "pending";
             $loan_transaction->amount = $request->amount;
             $loan_transaction->credit = $request->amount;
             $loan_transaction->save();

            //debit (the receiving account)
            // QNS - Is the transfer from group to group or balance from all groups sent to one officer.
             $loan_transaction = new LoanTransaction();
             $loan_transaction->created_by_id = Auth::id();
             $loan_transaction->loan_id = 0;
             $loan_transaction->branch_id = $to->branch_id;
             $loan_transaction->group_id = $to->id;
             $loan_transaction->register_id = $recipient->id;
             $loan_transaction->payment_detail_id = '';
             $loan_transaction->name = 'Funds Transfer';
             $loan_transaction->loan_transaction_type_id = 3;
             $loan_transaction->submitted_on = $request->date;
             $loan_transaction->created_on = $request->date;
             $loan_transaction->status = "pending";
             $loan_transaction->amount = $request->amount;
             $loan_transaction->debit = $request->amount;
             $loan_transaction->save();

            //Double entry on journals: on approval
            //credit the officer transferring account
            $journal_entry = new JournalEntry();
            $journal_entry->created_by_id = Auth::id();
            $journal_entry->payment_detail_id = '';
            $journal_entry->transaction_number = 'LT' . $loan_transaction->id;
            $journal_entry->branch_id = $from->branch_id;
            $journal_entry->currency_id = 3;
            $journal_entry->chart_of_account_id = User::find(Auth::id())->user_control_account;
            $journal_entry->transaction_type = 'cash_transfer';
            $journal_entry->date = $request->date;
            $date = explode('-', $request->date);
            $journal_entry->month = $date[1];
            $journal_entry->year = $date[0];
            $journal_entry->credit = $request->amount;
            $journal_entry->reference = $loan_transaction->id;
            $journal_entry->save();

            //debit account (the officer receiving account)
            $journal_entry = new JournalEntry();
            $journal_entry->created_by_id = Auth::id();
            $journal_entry->payment_detail_id = '';
            $journal_entry->transaction_number = 'LT' . $loan_transaction->id;
            $journal_entry->branch_id = $to->branch_id;
            $journal_entry->currency_id = 3;
            $journal_entry->chart_of_account_id = $recipient_officer->user_control_account;
            $journal_entry->transaction_type = 'cash_transfer';
            $journal_entry->date = $request->date;
            $date = explode('-', $request->date);
            $journal_entry->month = $date[1];
            $journal_entry->year = $date[0];
            $journal_entry->debit = $request->amount;
            $journal_entry->reference = $loan_transaction->id;
            $journal_entry->save();

        
        }

    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        //check if the user has any open registers.
        $open = Register::where('status', 'active')->where('user_id', Auth::id())->first();
        if(!empty($open))
        {
            return response()->json(['message' => 'The user has an open register. Close to continue. '], 400);
        }
        else{
            $register = Register::create([
                'code'=> Str::upper(Str::random(6)),
                'user_id'=>Auth::id(),
                'status'=>'active',
                'notes'=>$request->notes
            ]);

            DB::table('register_notes')->insert([
                'register_id' => $register->id,
                'action'=>'activated',
                'notes'=>$request->notes,
                'user_id'=>Auth::id(),
            ]);
            return response()->json(['message' => 'A new register has been opened. ']);
        }

    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        $data1 = [ 
        // 'groups' => Group::with(['payment_details' => function($query) use ($id){
        //     $query->where('payment_details.register_id', $id);
        'groups' => DB::table('payment_details')->join('client_groups', 'payment_details.group_id', 'client_groups.id')
        ->where('payment_details.register_id', $id)
        ->groupBy('payment_details.group_id')
            // $query->sum('payment_details.amount');
            // $query->groupBy('payment_details.transaction_type');
        ->get(),
        // ->with(['clients.loans.loan_product'=>function($query){
        //     // $query->where('clients.status', 'active');
        //     $query->orderBy('loan_products.id', 'asc');
        // }])->with(['clients.loans.repayment_schedules'=>function($query){
        //     $query->selectRaw('loan_repayment_schedules.loan_id, SUM(loan_repayment_schedules.principal) total_principal, SUM(loan_repayment_schedules.principal_written_off_derived) principal_written_off_derived, SUM(loan_repayment_schedules.principal_repaid_derived) principal_repaid_derived, SUM(loan_repayment_schedules.interest) total_interest, SUM(loan_repayment_schedules.interest_waived_derived) interest_waived_derived,SUM(loan_repayment_schedules.interest_written_off_derived) interest_written_off_derived,  SUM(loan_repayment_schedules.interest_repaid_derived) interest_repaid_derived,SUM(loan_repayment_schedules.fees) total_fees, SUM(loan_repayment_schedules.fees_waived_derived) fees_waived_derived, SUM(loan_repayment_schedules.fees_written_off_derived) fees_written_off_derived, SUM(loan_repayment_schedules.fees_repaid_derived) fees_repaid_derived,SUM(loan_repayment_schedules.penalties) total_penalties, SUM(loan_repayment_schedules.penalties_waived_derived) penalties_waived_derived, SUM(loan_repayment_schedules.penalties_written_off_derived) penalties_written_off_derived, SUM(loan_repayment_schedules.penalties_repaid_derived) penalties_repaid_derived');
        //     $query->groupBy('loan_repayment_schedules.loan_id');
        // }])
        // ->with('clients.savings.savings_product')
        // ->with(['clients.savings'=>function($query){
        //     $query->where('savings.status', 'active');
        //     $query->groupBy('savings.client_id');
        // }])->with(['clients.loans' => function ($query) {
        //     $query->where('loans.status', 'active');
        // }])->find($id),
        'expenses' => Expense::leftJoin('expense_types', 'expenses.expense_type_id', 'expense_types.id')
        ->selectRaw('expense_types.name, SUM(expenses.amount) expense_amount')
        // ->where('expenses.group_id', $id)
        ->where('expenses.register_id', $id)
        ->groupBy('expenses.expense_type_id')
        ->get(),
        'incomes' => Income::join('income_types', 'income.income_type_id', 'income_types.id')
        ->selectRaw('income_types.name, SUM(income.amount) income_amount')
        // ->where('income.group_id', $id)
        ->where('income.register_id', $id)
        ->groupBy('income.income_type_id')
        ->get(),
        'disburse' => Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->selectRaw('SUM(loan_transactions.amount) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name')
        // ->where('loan_transactions.group_id', $id)
        ->where('loan_transactions.loan_transaction_type_id', 1)
        ->where('loan_transactions.register_id', $id)
        ->groupBy('loan_products.id')
        ->get(),
        'repayment' => Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->selectRaw('SUM(loan_transactions.amount) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name')
        // ->where('loan_transactions.group_id', $id)
        ->where('loan_transactions.loan_transaction_type_id', 2)
        ->where('loan_transactions.register_id', $id)
        ->groupBy('loan_products.id')
        ->get(),
        'methods' => PaymentDetail::join('payment_types', 'payment_details.payment_type_id', '=', 'payment_types.id')
        ->selectRaw('SUM(payment_details.amount) total_amount, payment_types.name, payment_types.is_cash')
        ->where('payment_details.register_id', $id)
        // ->where('payment_details.group_id', $id)
        ->whereIn('payment_details.transaction_type', ['loan_transaction', 'savings_transaction', 'income'])
        ->groupBy('payment_details.payment_type_id')
        ->get(),        
        'savings' => Savings::join('savings_products', 'savings.savings_product_id', 'savings_products.id')
        ->join('savings_transactions', 'savings.id', 'savings_transactions.savings_id')
        ->join('savings_transaction_types', 'savings_transactions.savings_transaction_type_id', 'savings_transaction_types.id')
        ->selectRaw('SUM(savings_transactions.credit) as total_savings, SUM(savings_transactions.debit) as total_withdrawal, savings_products.name product_name, savings_transactions.name transaction_name')
        // ->where('savings_transactions.group_id', $id)
        ->where('savings_transactions.savings_transaction_type_id', 1)
        ->where('savings_transactions.register_id', $id)
        ->groupBy('savings_products.id')
        ->get(),
        'registers' => Register::with('user')->with(['payment_details'=>function ($query) use ($id) {
            $query->where('payment_details.register_id', $id);
            $query->orderBy('payment_details.created_at', 'asc');
        }])
        ->with('payment_details.payment_type')
        ->with(['loan_transactions'=>function($query) use ($id){
            $query->where('loan_transactions.register_id', $id);
        }])
        ->with(['savings_transactions'=>function($query) use ($id){
            $query->where('savings_transactions.register_id', $id);
        }])
        // ->where
        ->find($id)
        ];

        return response()->json($data1);
    }

    // Register approval
    public function register_approval(Request $request, $id)
    {
        $register = Register::find($id);
        if($register->approved == 1)
        {
            return response()->json(['message' => 'The register has been approved by '.User::find($register->approved_by_user_id)->first_name], 400);
        }
        elseif($register->status != 'closed')
        {
            return response()->json(['message' => 'The register has not been closed by the user.'], 400);
        }else{
            $register->update([
                'status'=>'approved',
                'approved' => 1,
                'approved_by_user_id'=> Auth::id(),
                'approval_notes'=>$request->notes,
                'approval_time'=>date('Y-m-d H:i:s')
            ]);
            DB::table('register_notes')->insert([
                'register_id' => $id,
                'action'=>'approved',
                'notes'=>$request->notes,
                'user_id'=>Auth::id(),
            ]);

            return response()->json(['message' => 'The register appproval is successful.']);
        }
    }

    // Close register for approval
    public function close_register(Request $request, $id)
    {
        $register = Register::find($id);
        if($register->approved == 1)
        {
            return response()->json(['message' => 'The register has been approved and closed for editing.'], 400);
        }
        elseif($register->status == 'closed')
        {
            return response()->json(['message' => 'The register has already been closed for editing.'], 400);
        }else{
            $register->update([
                'status'=>'closed',
                'approved' => 0,
                'closed_by_user_id'=> Auth::id(),
                'closing_notes'=>$request->notes,
                'closing_time'=>date('Y-m-d H:i:s')
            ]);

            DB::table('register_notes')->insert([
                'register_id' => $id,
                'action'=>'closed',
                'notes'=>$request->notes,
                'user_id'=>Auth::id(),
            ]);

            return response()->json(['message' => 'The register has been closed successfully.']);
        }
    }

    // Reopen register for approval
    public function reopen_register(Request $request, $id)
    {
        $register = Register::find($id);
        if($register->approved == 1)
        {
            return response()->json(['message' => 'The register has been approved and closed for editing.'], 400);
        }
        elseif($register->status != 'closed')
        {
            return response()->json(['message' => 'The register has NOT been closed for editing.'], 400);
        }else{
            $register->update([
                'status'=>'reopened',
                'approved' => 0,                
            ]);

            DB::table('register_notes')->insert([
                'register_id' => $id,
                'action'=>'reopened',
                'notes'=>$request->notes,
                'user_id'=>Auth::id(),
            ]);
            return response()->json(['message' => 'The register has been closed successfully.']);
        }
    }

    public function find_open_register(){
        $user_id = Auth::id();
        $open = Register::where('status', 'active')->where('user_id', Auth::id())->first();

        // return response()->json([''])
        // return response()->json(['message'=>'Nice to meet you Nick']);
        if($open){
            return ['success'=>true, 'register'=>$open];
        }else{
            return ['success'=>false, 'register'=>$open];
        }
    }

    public function group_register_expenses($id)
    {
        $current_register = Register::where('status', 'active')->where('user_id', Auth::id())->first();
        // get expenses
        $expenses = Expense::leftJoin('expense_types', 'expenses.expense_type_id', 'expense_types.id')
        ->selectRaw('expense_types.name, SUM(expenses.amount) expense_amount')
        ->where('expenses.group_id', $id)
        ->where('expenses.register_id', $current_register->id)
        ->groupBy('expenses.expense_type_id')
        ->get();
        $incomes = Income::join('income_types', 'income.income_type_id', 'income_types.id')
        ->selectRaw('income_types.name, SUM(income.amount) income_amount')
        ->where('income.group_id', $id)
        ->where('income.register_id', $current_register->id)
        ->groupBy('income.income_type_id')
        ->get();
        $disburse = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        // ->join('payment_details', 'loan_transactions.payment_detail_id', 'payment_details.id')
        ->selectRaw('SUM(loan_transactions.debit) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name')
        ->where('loan_transactions.group_id', $id)
        ->where('loan_transactions.loan_transaction_type_id', 1)
        ->where('loan_transactions.register_id', $current_register->id)
        ->groupBy('loan_products.id')
        ->get();
        $cash = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->join('payment_details', 'loan_transactions.payment_detail_id', 'payment_details.id')
        ->selectRaw('SUM(loan_transactions.debit) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name')
        ->where('loan_transactions.group_id', $id)
        ->where('loan_transactions.loan_transaction_type_id', 1)
        ->where('payment_details.payment_type_id', 1)
        ->where('loan_transactions.register_id', $current_register->id)
        ->groupBy('loan_products.id', 'payment_details.id')
        ->get();
        $transfers = LoanTransaction::join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        // ->join('payment_details', 'loan_transactions.payment_detail_id', 'payment_details.id')
        ->selectRaw('SUM(loan_transactions.debit) debit, SUM(loan_transactions.credit) credit, loan_transactions.name transaction_name')
        ->where('loan_transactions.group_id', $id)
        ->where('loan_transactions.loan_transaction_type_id', 3)
        // ->where('payment_details.payment_type_id', 1)
        ->where('loan_transactions.register_id', $current_register->id)
        // ->groupBy('loan_products.id', 'payment_details.id')
        ->get();
        $repayment = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->selectRaw('SUM(loan_transactions.amount) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name, loan_transaction_types.id')
        ->where('loan_transactions.group_id', $id)
        ->where('loan_transaction_types.id', 2)
        ->where('loan_transactions.register_id', $current_register->id)
        ->groupBy('loan_products.id')
        ->get();
        $fees = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->selectRaw('SUM(loan_transactions.amount) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name, loan_transaction_types.id')
        ->where('loan_transactions.group_id', $id)
        ->where('loan_transaction_types.id', 5)
        ->where('loan_transactions.register_id', $current_register->id)
        ->groupBy('loan_products.id')
        ->get();
        $methods = PaymentDetail::join('payment_types', 'payment_details.payment_type_id', '=', 'payment_types.id')
        ->selectRaw('SUM(payment_details.amount) total_amount, payment_types.name, payment_details.payment_type_id id, payment_details.register_id')
        ->where('payment_details.register_id', $current_register->id)
        ->where('payment_details.group_id', $id)
        ->whereIn('payment_details.transaction_type', ['loan_transaction', 'savings_transaction', 'income'])
        ->groupBy('payment_details.payment_type_id')
        ->get();
        
        $savings = Savings::join('savings_products', 'savings.savings_product_id', 'savings_products.id')
        ->join('savings_transactions', 'savings.id', 'savings_transactions.savings_id')
        ->join('savings_transaction_types', 'savings_transactions.savings_transaction_type_id', 'savings_transaction_types.id')
        ->selectRaw('SUM(savings_transactions.amount) total_amount, savings_products.name product_name, savings_transactions.name transaction_name')
        ->where('savings_transactions.group_id', $id)
        ->where('savings_transactions.savings_transaction_type_id', 1)
        ->where('savings_transactions.register_id', $current_register->id)
        ->groupBy('savings_products.id')
        ->get();

        $withdrawals = SavingsTransaction::selectRaw('sum(savings_transactions.debit) total_withdrawal')
        ->where('savings_transactions.group_id', $id)
        ->where('savings_transactions.savings_transaction_type_id', 2)
        ->where('savings_transactions.register_id', $current_register->id)
        ->groupBy('savings_transactions.group_id')
        ->get();

        return [
            'fees' => $fees,
            'transfers'=>$transfers, 
            'cash'=>$cash, 
            'expenses'=> $expenses, 
            'incomes'=>$incomes, 
            'disburses'=>$disburse, 
            'repayments'=>$repayment, 
            'methods'=>$methods, 
            'savings'=>$savings, 
            'withdrawals'=>$withdrawals
        ];
    }


    public function detailed_group_register($register_id, $group_id)
    {
        $current_register = Register::where('status', 'active')->where('user_id', Auth::id())->first();
        // get expenses
        $expenses = Expense::leftJoin('expense_types', 'expenses.expense_type_id', 'expense_types.id')
        ->selectRaw('expense_types.name, SUM(expenses.amount) expense_amount')
        ->where('expenses.group_id', $group_id)
        ->where('expenses.register_id', $register_id)
        ->groupBy('expenses.expense_type_id')
        ->get();
        $incomes = Income::join('income_types', 'income.income_type_id', 'income_types.id')
        ->selectRaw('income_types.name, SUM(income.amount) income_amount')
        ->where('income.group_id', $group_id)
        ->where('income.register_id', $register_id)
        ->groupBy('income.income_type_id')
        ->get();
        $disburse = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->join('payment_details', 'loan_transactions.payment_detail_id', 'payment_details.id')
        ->join('payment_types', 'payment_details.payment_type_id', 'payment_types.id')
        ->selectRaw('payment_details.payment_type_id, loan_products.id, payment_types.name, SUM(loan_transactions.debit) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name')
        ->where('loan_transactions.group_id', $group_id)
        ->where('loan_transactions.loan_transaction_type_id', 1)
        ->where('loan_transactions.register_id', $register_id)
        ->groupBy('loan_products.id', 'payment_details.payment_type_id')
        ->get();
        $cash = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->join('payment_details', 'loan_transactions.payment_detail_id', 'payment_details.id')
        ->selectRaw('SUM(loan_transactions.debit) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name')
        ->where('loan_transactions.group_id', $group_id)
        ->where('loan_transactions.loan_transaction_type_id', 1)
        ->where('payment_details.payment_type_id', 1)
        ->where('loan_transactions.register_id', $register_id)
        ->groupBy('loan_products.id', 'payment_details.id')
        ->get();
        $transfers = LoanTransaction::join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        // ->join('payment_details', 'loan_transactions.payment_detail_id', 'payment_details.id')
        ->selectRaw('SUM(loan_transactions.debit) debit, SUM(loan_transactions.credit) credit, loan_transactions.name transaction_name')
        ->where('loan_transactions.group_id', $group_id)
        ->where('loan_transactions.loan_transaction_type_id', 3)
        // ->where('payment_details.payment_type_id', 1)
        ->where('loan_transactions.register_id', $register_id)
        // ->groupBy('loan_products.id', 'payment_details.id')
        ->get();
        $repayment = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->selectRaw('SUM(loan_transactions.credit) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name, loan_transaction_types.id')
        ->where('loan_transactions.group_id', $group_id)
        ->whereIn('loan_transaction_types.id', [2, 8])
        ->where('loan_transactions.register_id', $register_id)
        ->groupBy('loan_products.id')
        ->get();
        $fees = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->selectRaw('SUM(loan_transactions.amount) transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name, loan_transaction_types.id')
        ->where('loan_transactions.group_id', $group_id)
        ->where('loan_transaction_types.id', 5)
        ->where('loan_transactions.register_id', $register_id)
        ->groupBy('loan_products.id')
        ->get();
        $methods = PaymentDetail::join('payment_types', 'payment_details.payment_type_id', '=', 'payment_types.id')
        ->selectRaw('SUM(payment_details.amount) total_amount, payment_types.name, payment_details.payment_type_id id, payment_details.register_id')
        ->where('payment_details.register_id', $register_id)
        ->where('payment_details.group_id', $group_id)
        ->whereIn('payment_details.transaction_type', ['loan_transaction', 'savings_transaction', 'loan_disbursement', 'income', 'loan_repayment'])
        ->groupBy('payment_details.payment_type_id')
        ->get();
        
        $savings = Savings::join('savings_products', 'savings.savings_product_id', 'savings_products.id')
        ->join('savings_transactions', 'savings.id', 'savings_transactions.savings_id')
        ->join('savings_transaction_types', 'savings_transactions.savings_transaction_type_id', 'savings_transaction_types.id')
        ->join('payment_details', 'savings_transactions.payment_detail_id', 'payment_details.id')
        ->join('payment_types', 'payment_details.payment_type_id', 'payment_types.id')
        ->selectRaw('payment_details.payment_type_id, savings_products.id, payment_types.name, SUM(savings_transactions.amount) total_amount, savings_products.name product_name, savings_transactions.name transaction_name, savings_products.id id')
        ->where('savings_transactions.group_id', $group_id)
        ->where('savings_transactions.savings_transaction_type_id', 1)
        ->where('savings_transactions.register_id', $register_id)
        ->groupBy('savings_products.id', 'payment_types.id')
        ->get();

        $withdrawals = SavingsTransaction::join('savings_transaction_types', 'savings_transactions.savings_transaction_type_id', 'savings_transaction_types.id')
        ->selectRaw('sum(savings_transactions.debit) total_withdrawal, savings_transaction_types.name')
        ->where('savings_transactions.group_id', $group_id)
        ->whereIn('savings_transactions.savings_transaction_type_id', [2, 7])
        ->where('savings_transactions.register_id', $register_id)
        ->groupBy('savings_transactions.group_id')
        ->get();

        $txns = PaymentDetail::join('client_groups', 'payment_details.group_id', 'client_groups.id')
                ->selectRaw('client_groups.group_name, payment_details.transaction_type, sum(payment_details.amount) as txn_amount')
                ->where('payment_details.group_id', $group_id)
                ->where('payment_details.register_id', $register_id)
                ->groupBy('payment_details.transaction_type')
                ->get();

        return [
            'fees' => $fees,
            'transfers'=>$transfers, 
            'cash'=>$cash, 
            'expenses'=> $expenses, 
            'incomes'=>$incomes, 
            'disburses'=>$disburse, 
            'repayments'=>$repayment, 
            'methods'=>$methods, 
            'savings'=>$savings, 
            'withdrawals'=>$withdrawals
        ];
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('user::edit');
    }

        /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function group_register_summary($register_id, $group_id)
    {
        $txns = PaymentDetail::join('client_groups', 'payment_details.group_id', 'client_groups.id')
                ->selectRaw('client_groups.group_name, payment_details.transaction_type, sum(payment_details.amount) as txn_amount')
                ->where('payment_details.group_id', $group_id)
                ->where('payment_details.register_id', $register_id)
                ->groupBy('payment_details.transaction_type')
                ->get();
        $loans = Group::join('loan_transactions', 'client_groups.id', 'loan_transactions.group_id')
                ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
                ->selectRaw('client_groups.group_name, loan_transaction_types.name, sum(loan_transactions.amount) as txn_amount')
                ->whereIn('loan_transaction_types.id', [1, 2, 5, 8])
                ->where('loan_transactions.group_id', $group_id)
                ->where('loan_transactions.register_id', $register_id)
                ->groupBy('loan_transaction_types.id')
                ->get();
        $savings = Group::join('savings_transactions', 'client_groups.id', 'savings_transactions.group_id')
                ->join('savings_transaction_types', 'savings_transactions.savings_transaction_type_id', 'savings_transaction_types.id')
                ->selectRaw('client_groups.group_name, savings_transaction_types.name, sum(savings_transactions.amount) as txn_amount, savings_transaction_types.id id')
                ->where('savings_transactions.group_id', $group_id)
                ->where('savings_transactions.register_id', $register_id)
                ->groupBy('savings_transaction_types.id')
                ->get();
        $incomes = Group::join('income', 'client_groups.id', 'income.group_id')
                ->join('income_types', 'income.income_type_id', 'income_types.id')
                ->selectRaw('client_groups.group_name, income_types.name, sum(income.amount) as txn_amount')
                ->where('income.group_id', $group_id)
                ->where('income.register_id', $register_id)
                ->groupBy('income_types.id')
                ->get();

        return response()->json(['txns'=>$txns, 'loans'=>$loans, 'savings'=>$savings, 'incomes'=>$incomes]);
    }

    public function get_transactions($register_id, $group_id, $type)
    {

        $savings = Savings::join('savings_products', 'savings.savings_product_id', 'savings_products.id')
                ->join('savings_transactions', 'savings.id', 'savings_transactions.savings_id')
                ->join('savings_transaction_types', 'savings_transactions.savings_transaction_type_id', 'savings_transaction_types.id')
                ->join('clients', 'savings.client_id', 'clients.id')
                // ->join('savings_transactions', '')
                ->selectRaw('concat(clients.first_name," ", clients.middle_name," ", clients.last_name) full_name, savings_transactions.amount amount, savings_transactions.debit debit, savings_transactions.credit credit, savings_products.name product_name, savings_transactions.name transaction_name, savings_transactions.id id')
                ->where('savings_transactions.group_id', $group_id)
                ->where('savings_transactions.savings_transaction_type_id', 1)
                // ->where('savings_transactions.savings_transaction_type_id', $type)
                ->where('savings_products.id', $type)
                ->where('savings_transactions.register_id', $register_id)
                // ->groupBy('savings_products.id', 'savings_transactions.savings_transaction_type_id')
                ->get();
        
        return response()->json(['savings'=>$savings]);
    }


    public function get_cash_transactions($register_id, $group_id, $type)
    {

        $txn = PaymentDetail::join('payment_types', 'payment_details.payment_type_id', '=', 'payment_types.id')
        ->selectRaw('payment_details.id txn_id, payment_details.transaction_type, payment_details.amount total_amount, payment_types.name, payment_details.payment_type_id id, payment_details.register_id')
        ->where('payment_details.register_id', $register_id)
        ->where('payment_details.group_id', $group_id)
        ->whereIn('payment_details.transaction_type', ['loan_transaction', 'savings_transaction', 'income', 'loan_repayment'])
        ->where('payment_details.payment_type_id', $type)
        // ->groupBy('payment_details.payment_type_id')
        ->get();
        
        return response()->json(['transactions'=>$txn]);
    }

    public function get_loans_transactions($register_id, $group_id, $product, $payment_type)
    {

        $details = Loan::join('loan_products', 'loans.loan_product_id', 'loan_products.id')
        ->join('clients', 'loans.client_id', 'clients.id')
        ->join('loan_transactions', 'loans.id', 'loan_transactions.loan_id')
        ->join('loan_transaction_types', 'loan_transactions.loan_transaction_type_id', 'loan_transaction_types.id')
        ->join('payment_details', 'loan_transactions.payment_detail_id', 'payment_details.id')
        ->join('payment_types', 'payment_details.payment_type_id', 'payment_types.id')
        ->selectRaw('loans.id trans_id, clients.first_name, clients.last_name, payment_details.payment_type_id, loan_products.id, payment_types.name, loan_transactions.debit transaction_amount, loan_products.name product_name, loan_transactions.name transaction_name')
        ->where('loan_transactions.group_id', $group_id)
        ->where('loan_products.id', $product)
        ->where('payment_details.payment_type_id', $payment_type)
        ->where('loan_transactions.loan_transaction_type_id', 1)
        ->where('loan_transactions.register_id', $register_id)
        // ->groupBy('loan_products.id', 'payment_details.payment_type_id')
        ->get();
        
        return response()->json(['transactions'=>$details]);
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
