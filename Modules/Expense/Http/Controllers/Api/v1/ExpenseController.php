<?php

namespace Modules\Expense\Http\Controllers\Api\v1;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Expense\Entities\Expense;
use Modules\Expense\Entities\ExpenseType;
use Illuminate\Support\Facades\Auth;
use Modules\User\Entities\Register;
use Illuminate\Support\Facades\Validator;
use Modules\Accounting\Entities\JournalEntry;
use Modules\Core\Entities\PaymentDetail;
use Modules\Core\Entities\PaymentType;
use Modules\Client\Entities\Group;

class ExpenseController extends Controller
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
        $expense = Expense::with('expense_type')->with('branch')->with('group')->with('register')->with('register.user')->get();
        return response()->json([$expense]);
    }

    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function types()
    {
        $expense = ExpenseType::all();
        return response()->json($expense);
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('expense::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {

        $expense = $request->all();
        $input = Validator::make($request->all(), [
            'amount' => ['required'], ['numeric'],
            'expense_type_id' => ['required'],
            'payment_type_id' => ['required'],
            'recurring'=> ['boolean'],
            'recur_start_date' => 'required_if:recurring,true,after:today',
            'recur_end_date' => 'required_if:recurring,true,after:recur_start_date ',
            'recur_frequency' => 'required_if:recurring,true,numeric',
            'group_id' => ['required']
        ]);

        //

        // group ID
        // return $request;
        if ($input->fails()) {
            return response()->json($input->errors(), 400);
        } else {

            $expense = new Expense();
            $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;
            $branch_id = Group::find($request->group_id)->branch_id;
            $chart = ExpenseType::find($request->expense_type_id);
            $expense->created_by_id = Auth::id();
            $expense->expense_type_id = $request->expense_type_id;
            $expense->register_id = $reg_id;
            $expense->payment_type_id = $request->payment_type_id;
            $expense->receipt = $request->receipt;
            $expense->group_id = $request->group_id;
            $expense->currency_id = 3;
            $expense->branch_id = $branch_id;
            $expense->expense_chart_of_account_id = $chart->expense_chart_of_account_id;
            $expense->asset_chart_of_account_id = $chart->asset_chart_of_account_id;
            $expense->amount = $request->amount;
            $expense->date = $request->date;
            $expense->recurring = $request->recurring;
            if ($request->recurring == 1) {
                $expense->recur_frequency = $request->recur_frequency;
                $expense->recur_start_date = $request->recur_start_date;
                $expense->recur_end_date = $request->recur_end_date;
                $expense->recur_type = $request->recur_type;
            }
            $expense->description = $request->description;
            $expense->save();
            $payment_detail = new PaymentDetail();
            $payment_detail->created_by_id = Auth::id();
            $payment_detail->payment_type_id = $request->payment_type_id;
            $payment_detail->amount = $request->amount;
            $payment_detail->group_id = $expense->group_id;
            $payment_detail->branch_id = $expense->branch_id;
            $payment_detail->register_id = $reg_id;
            $payment_detail->transaction_type = 'expense';
            $payment_detail->cheque_number = $request->cheque_number;
            $payment_detail->receipt = $request->receipt;
            $payment_detail->account_number = $request->account_number;
            $payment_detail->bank_name = $request->bank_name;
            $payment_detail->routing_code = $request->routing_code;
            $payment_detail->save();
            //credit journal entries
            if (!empty($request->expense_type_id)) {
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->payment_detail_id = $payment_detail->id;
                $journal_entry->transaction_number = $expense->id;
                $journal_entry->branch_id = $branch_id;
                $journal_entry->currency_id = 3;
                if(PaymentType::find($request->payment_type_id)->is_cash == 1)
                {
                    $journal_entry->chart_of_account_id = Auth::user()->user_control_account;
                }else{
                    $journal_entry->chart_of_account_id = PaymentType::find($request->payment_type_id)->asset_control_account;
                }
                // $journal_entry->chart_of_account_id = $chart->expense_chart_of_account_id;
                $journal_entry->transaction_type = 'expense';
                $journal_entry->date = date('Y-m-d');
                $date = explode('-', date('Y-m-d'));
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
                $journal_entry->credit = $request->amount;
                $journal_entry->reference = $expense->receipt;
                $journal_entry->notes = $request->notes;
                $journal_entry->save();
            }
            // debit account
            if (!empty($request->expense_type_id)) {
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->payment_detail_id = $payment_detail->id;
                $journal_entry->transaction_number = $expense->id;
                $journal_entry->branch_id = $branch_id;
                $journal_entry->currency_id = 3;
                
                $journal_entry->chart_of_account_id = $chart->expense_chart_of_account_id;
                $journal_entry->transaction_type = 'expense';
                $journal_entry->date = date('Y-m-d');
                $date = explode('-', date('Y-m-d'));
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
                $journal_entry->debit = $request->amount;
                $journal_entry->reference = $expense->id;
                $journal_entry->notes = $request->notes;
                $journal_entry->save();
            }
            activity()->on($expense)
            ->withProperties(['id' => $expense->id])
            ->log('Create Expense');
            \flash(trans_choice("core::general.successfully_saved", 1))->success()->important();

        }
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('expense::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('expense::edit');
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
