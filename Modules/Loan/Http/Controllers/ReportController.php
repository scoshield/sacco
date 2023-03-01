<?php

namespace Modules\Loan\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use Modules\Branch\Entities\Branch;
use Modules\Loan\Entities\Loan;
use Modules\Loan\Entities\LoanProduct;
use Modules\Loan\Exports\LoanExport;
use Modules\User\Entities\User;
use Modules\Client\Entities\Client;
use Modules\Savings\Entities\Savings;
use PDF;
use Modules\Client\Entities\Group;

class ReportController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
        $this->middleware(['permission:loan.loans.reports.repayments'])->only(['repayment']);
        $this->middleware(['permission:loan.loans.reports.collection_sheet'])->only(['collection_sheet']);
        $this->middleware(['permission:loan.loans.reports.expected_repayments'])->only(['expected_repayment']);
        $this->middleware(['permission:loan.loans.reports.arrears'])->only(['arrears']);
        $this->middleware(['permission:loan.loans.reports.disbursements'])->only(['disbursement']);
    }

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        return theme_view('loan::report.index');
    }

    /**
     * Show the form for creating a new resource.
     * @return Response
     */
    public function collection_sheet(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $group_id = $request->group_id;
        $loan_product_id = $request->loan_product_id;
        $loan_officer_id = $request->loan_officer_id;
        // $group_name = Group::find($group_id)->group_name;
        $customPaper = array(0,0,567.00,283.80);
        $users = User::whereHas('roles', function ($query) {
            return $query->where('name', '!=', 'client');
        })->get();
        $data = [];
        $groups = Group::all();
        $branches = Branch::all();
        $loan_products = LoanProduct::all();
        
        $clients = Client::with(['loans' => function($query){
            $query->where('loan.status', 'active');
        }])
        ->with(['client_group' => function($query) use ($group_id){
            $query->where('client_groups.id', $group_id);
        }])
        ->with('loans.loan_product')
        ->with(['loans.repayment_schedules' => function($query) use ($start_date, $end_date){
            $query->whereBetween('loan_repayment_schedules.due_date', [$start_date, $end_date]);
            $query->where('loan_repayment_schedules.total_due', '>', 0);
        }])
        ->with('savings')
        ->with('savings.savings_product')
        ->where('group_id', $group_id)
        ->where('status', 'active')
        ->get();
        
        if (!empty($start_date)) {
            
            $data = Client::with(['loans' => function($query){
                    $query->whereIn('loans.status', 'active');
                }])
                ->with('client_group', function($query) use ($group_id){
                    $query->where('client_groups.id', $group_id);
                })
                ->with('loans.loan_product')
                ->with('loans.repayment_schedules', function($query) use ($start_date, $end_date){
                    $query->whereBetween('loan_repayment_schedules.due_date', [$start_date, $end_date]);
                    $query->where('loan_repayment_schedules.total_due', '>', 0);
                })
                ->with('savings', function($query){
                    $query->where('savings.status', 'active');
                })
                ->with('savings.savings_product')
                ->where('group_id', $group_id)
                ->where('status', 'active')
                ->get();

            $sum = DB::table("loan_repayment_schedules")
                ->join("loans", "loan_repayment_schedules.loan_id", "loans.id")
                ->join("loan_products", "loans.loan_product_id", "loan_products.id")
                ->join("clients", "loans.client_id", "clients.id")
                ->selectRaw("sum(loan_repayment_schedules.principal_balance) balance, loan_products.id, loan_products.name")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('loan_repayment_schedules.due_date', [$start_date, $end_date]);
                    $query->where("loan_repayment_schedules.total_due", ">", 0);
                })
                ->when($group_id, function ($query) use ($group_id) {
                    $query->where('clients.group_id', $group_id);
                })
                ->groupBy("loan_products.name")
                ->where('loans.status', 'active')
                ->get();
            $sum2 = DB::table("savings")
                ->join("savings_products", "savings.savings_product_id", "savings_products.id")
                ->join("clients", "savings.client_id", "clients.id")
                ->selectRaw("sum(balance_derived) balance, savings_products.id, savings_products.name")
                ->when($group_id, function ($query) use ($group_id) {
                    $query->where('clients.group_id', $group_id);
                })
                ->groupBy("savings_products.name")
                ->get();
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('loan::report.collection_sheet_pdf'), compact('start_date', 'sum', 'sum2',
                        'end_date', 'branch_id', 'groups', 'group_id', 'data', 'clients',  'branches', 'users', 'loan_officer_id', 'loan_product_id', 'loan_products'))->setPaper('a4', 'portrait');
                    return $pdf->download(Group::find($group_id)->group_name.' '. trans_choice('loan::general.collection_sheet', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                    // return response()->json($data);
                }
                $view = theme_view('loan::report.collection_sheet_pdf',
                    compact('start_date', 'groups', 'group_id', 'sum', 'sum2',
                        'end_date', 'branch_id', 'data', 'clients',  'branches', 'users', 'loan_officer_id', 'loan_product_id', 'loan_products'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.collection_sheet', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.collection_sheet', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.collection_sheet', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        // return response()->json($clients);
        return theme_view('loan::report.collection_sheet',
            compact('clients', 'start_date', 'group_id',
                'end_date', 'branch_id', 'data', 'branches', 'groups', 'group_id', 'users', 'loan_officer_id', 'loan_product_id', 'loan_products'));
    }

    public function collection_sheet1(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $group_id = $request->group_id;
        $loan_product_id = $request->loan_product_id;
        $loan_officer_id = $request->loan_officer_id;
        $users = User::whereHas('roles', function ($query) {
            return $query->where('name', '!=', 'client');
        })->get();
        $data = [];
        $groups = Group::all();
        $branches = Branch::all();
        $loan_products = LoanProduct::all();
        $clients = Client::with('loans')
        ->with('client_group', function($query) use ($group_id){
            $query->where('client_groups.id', $group_id);
        })
        ->with('loans.loan_product')
        ->with('loans.repayment_schedules', function($query) use ($start_date, $end_date){
            $query->whereBetween('loan_repayment_schedules.due_date', [$start_date, $end_date]);
            $query->where('loan_repayment_schedules.total_due', '>', 0);
        })
        ->with('savings')
        ->with('savings.savings_product')
        ->where('group_id', $group_id)
        ->get();
        
        if (!empty($start_date)) {
           
            $data = DB::table("loan_repayment_schedules")
                ->join("loans", "loan_repayment_schedules.loan_id", "loans.id")
                ->join("loan_products", "loans.loan_product_id", "loan_products.id")
                ->join("branches", "loans.branch_id", "branches.id")
                ->join("clients", "loans.client_id", "clients.id")
                ->join('client_groups', 'clients.group_id', 'client_groups.id')
                ->leftJoin("users", "loans.loan_officer_id", "users.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('loan_repayment_schedules.due_date', [$start_date, $end_date]);
                })
                // ->when($branch_id, function ($query) use ($branch_id) {
                //     $query->where('loans.branch_id', $branch_id);
                // })
                ->when($group_id, function ($query) use ($group_id) {
                    $query->where('clients.group_id', $group_id);
                })
                // ->when($loan_officer_id, function ($query) use ($loan_officer_id) {
                //     $query->where('loans.loan_officer_id', $loan_officer_id);
                // })
                // ->when($loan_product_id, function ($query) use ($loan_product_id) {
                //     $query->where('loans.loan_product_id', $loan_product_id);
                // })
                ->where('loans.status', 'active')
                ->where('loan_repayment_schedules.total_due', '>', 0)
                ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) loan_officer,branches.name branch,clients.mobile,loans.client_id,loan_products.name loan_product,loan_repayment_schedules.loan_id,loans.expected_maturity_date,loan_repayment_schedules.total_due,(loan_repayment_schedules.principal+loan_repayment_schedules.interest+loan_repayment_schedules.fees+loan_repayment_schedules.penalties-loan_repayment_schedules.principal_written_off_derived-loan_repayment_schedules.interest_written_off_derived-loan_repayment_schedules.fees_written_off_derived-loan_repayment_schedules.penalties_written_off_derived-loan_repayment_schedules.interest_waived_derived-loan_repayment_schedules.fees_waived_derived-loan_repayment_schedules.penalties_waived_derived) expected_amount,loan_repayment_schedules.due_date,loan_repayment_schedules.principal_balance, loan_repayment_schedules.principal, loan_repayment_schedules.interest, (loan_repayment_schedules.principal_repaid_derived + loan_repayment_schedules.interest_repaid_derived) total_repayment")
                ->get();
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('loan::report.collection_sheet_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'groups', 'group_id', 'data', 'clients',  'branches', 'users', 'loan_officer_id', 'loan_product_id', 'loan_products'));
                    return $pdf->download(trans_choice('loan::general.collection_sheet', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('loan::report.collection_sheet_pdf',
                    compact('start_date', 'groups', 'group_id',
                        'end_date', 'branch_id', 'data', 'clients',  'branches', 'users', 'loan_officer_id', 'loan_product_id', 'loan_products'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.collection_sheet', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.collection_sheet', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.collection_sheet', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        // return response()->json($clients);
        return theme_view('loan::report.collection_sheet',
            compact('clients', 'start_date',
                'end_date', 'branch_id', 'data', 'branches', 'groups', 'group_id', 'users', 'loan_officer_id', 'loan_product_id', 'loan_products'));
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function repayment(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $group_id = $request->group_id;
        $users = User::whereHas('roles', function ($query) {
            return $query->where('name', '!=', 'client');
        })->get();
        $data = [];
        $branches = Branch::all();
        if (!empty($start_date)) {
            $data = DB::table("loan_transactions")
                ->join("loans", "loan_transactions.loan_id", "loans.id")
                ->join("branches", "loans.branch_id", "branches.id")
                ->join("clients", "loans.client_id", "clients.id")
                ->join("client_groups", "clients.group_id", "client_groups.id")
                ->leftJoin("users", "loans.loan_officer_id", "users.id")
                ->leftJoin("payment_details", "loan_transactions.payment_detail_id", "payment_details.id")
                ->leftJoin("payment_types", "payment_details.payment_type_id", "payment_types.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('loan_transactions.submitted_on', [$start_date, $end_date]);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('loans.branch_id', $branch_id);
                })
                ->when($group_id, function ($query) use ($group_id) {
                    $query->where('clients.group_id', $group_id);
                })
                ->where('loan_transaction_type_id', 2)
                ->selectRaw("client_groups.group_name, clients.first_name,clients.middle_name,clients.last_name,concat(users.first_name,' ',users.last_name) loan_officer,branches.name branch,loans.client_id,loan_transactions.id,loan_transactions.loan_id,loan_transactions.principal_repaid_derived,loan_transactions.interest_repaid_derived,loan_transactions.fees_repaid_derived,loan_transactions.penalties_repaid_derived,loan_transactions.submitted_on,payment_types.name payment_type")
                ->get();
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('loan::report.repayment_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches'));
                    return $pdf->download(trans_choice('loan::general.repayment', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('loan::report.repayment_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.repayment', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.repayment', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.repayment', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('loan::report.repayment',
            compact('start_date', 'group_id',
                'end_date', 'branch_id', 'data', 'branches'));
    }

    public function expected_repayment(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $data = [];
        $branches = Branch::all();
        if (!empty($start_date)) {
            $data = DB::table("loan_repayment_schedules")
                ->join("loans", "loan_repayment_schedules.loan_id", "loans.id")
                ->join("branches", "loans.branch_id", "branches.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('loan_repayment_schedules.due_date', [$start_date, $end_date]);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('loans.branch_id', $branch_id);
                })
                ->where('loans.status', 'active')
                ->selectRaw("branches.name branch,loans.branch_id,coalesce(sum(loan_repayment_schedules.principal-loan_repayment_schedules.principal_written_off_derived),0) principal,coalesce(sum(loan_repayment_schedules.interest-loan_repayment_schedules.interest_written_off_derived-loan_repayment_schedules.interest_waived_derived),0) interest,coalesce(sum(loan_repayment_schedules.fees-loan_repayment_schedules.fees_written_off_derived-loan_repayment_schedules.fees_waived_derived),0) fees,coalesce(sum(loan_repayment_schedules.penalties-loan_repayment_schedules.penalties_written_off_derived-loan_repayment_schedules.penalties_waived_derived),0) penalties,coalesce(sum(loan_repayment_schedules.principal_repaid_derived),0) principal_repaid_derived,coalesce(sum(loan_repayment_schedules.interest_repaid_derived),0) interest_repaid_derived,coalesce(sum(loan_repayment_schedules.fees_repaid_derived),0) fees_repaid_derived,coalesce(sum(loan_repayment_schedules.penalties_repaid_derived),0) penalties_repaid_derived")
                ->groupBy('branches.id')
                ->get();
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('loan::report.expected_repayment_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches'));
                    return $pdf->download(trans_choice('loan::general.expected', 1) . ' ' . trans_choice('loan::general.repayment', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('loan::report.expected_repayment_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.expected', 1) . ' ' . trans_choice('loan::general.repayment', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.expected', 1) . ' ' . trans_choice('loan::general.repayment', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.expected', 1) . ' ' . trans_choice('loan::general.repayment', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('loan::report.expected_repayment',
            compact('start_date',
                'end_date', 'branch_id', 'data', 'branches'));
    }

    public function arrears(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $data = [];
        $branches = Branch::all();
        if (!empty($end_date)) {
            $data = Loan::with("repayment_schedules")
                ->join(DB::raw("(select*from loan_repayment_schedules where loan_repayment_schedules.due_date<'$end_date' and total_due>0) loan_repayment_schedules"), "loan_repayment_schedules.loan_id", "loans.id")
                ->join("branches", "loans.branch_id", "branches.id")
                ->join("loan_products", "loans.loan_product_id", "loan_products.id")
                ->join("clients", "loans.client_id", "clients.id")
                ->leftJoin("users", "loans.loan_officer_id", "users.id")
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('loans.branch_id', $branch_id);
                })
                ->where('loans.status', 'active')
                ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,clients.mobile,concat(users.first_name,' ',users.last_name) loan_officer,branches.name branch,clients.mobile,loans.client_id,loan_products.name loan_product,loans.expected_maturity_date,loans.disbursed_on_date,loans.id,(SELECT submitted_on FROM loan_transactions WHERE loan_id=loans.id ORDER BY submitted_on DESC LIMIT 1) last_payment_date,loans.principal")
                ->groupBy('loans.id')
                ->get();
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('loan::report.arrears_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches'))->setPaper('A4', 'landscape');
                    return $pdf->download(trans_choice('loan::general.arrears', 1) . '( as at ' . $end_date . ').pdf');
                }
                $view = theme_view('loan::report.arrears_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.arrears', 1) . '(as at ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.arrears', 1) . '(as at ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.arrears', 1) . '(as at' . $end_date . ').csv');
                }
            }
        }
        return theme_view('loan::report.arrears',
            compact('start_date',
                'end_date', 'branch_id', 'data', 'branches'));
    }

    public function disbursement(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $loan_product_id = $request->loan_product_id;
        $status = $request->status;
        $loan_officer_id = $request->loan_officer_id;
        $users = User::whereHas('roles', function ($query) {
            return $query->where('name', '!=', 'client');
        })->get();
        $loan_products = LoanProduct::all();
        $data = [];
        $branches = Branch::all();
        if (!empty($start_date)) {
            $data = Loan::with("repayment_schedules")
                ->join("branches", "loans.branch_id", "branches.id")
                ->join("funds", "loans.fund_id", "funds.id")
                ->join("loan_purposes", "loans.loan_purpose_id", "loan_purposes.id")
                ->join("loan_products", "loans.loan_product_id", "loan_products.id")
                ->join("clients", "loans.client_id", "clients.id")
                ->leftJoin("users", "loans.loan_officer_id", "users.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('loans.disbursed_on_date', [$start_date, $end_date]);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('loans.branch_id', $branch_id);
                })
                ->when($loan_officer_id, function ($query) use ($loan_officer_id) {
                    $query->where('loans.loan_officer_id', $loan_officer_id);
                })
                ->when($loan_product_id, function ($query) use ($loan_product_id) {
                    $query->where('loans.loan_product_id', $loan_product_id);
                })
                ->when($status, function ($query) use ($status) {
                    $query->where('loans.status', $status);
                })
                ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,loans.status,clients.gender,clients.dob,clients.mobile,concat(users.first_name,' ',users.last_name) loan_officer,loan_purposes.name loan_purpose,funds.name fund,branches.name branch,clients.mobile,loans.client_id,loan_products.name loan_product,loans.expected_maturity_date,loans.disbursed_on_date,loans.id,loans.principal,loans.status,loans.repayment_frequency,loans.repayment_frequency_type")
                ->get();
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('loan::report.disbursement_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'loan_officer_id', 'loan_product_id', 'loan_products', 'users', 'status'))->setPaper('A4', 'landscape');
                    return $pdf->download(trans_choice('loan::general.disbursement', 1) . '(' . $start_date . '  to ' . $end_date . ').pdf');
                }
                $view = theme_view('loan::report.arrears_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'loan_officer_id', 'loan_product_id', 'loan_products', 'users', 'status'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.disbursement', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.disbursement', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new LoanExport($view), trans_choice('loan::general.disbursement', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('loan::report.disbursement',
            compact('start_date',
                'end_date', 'branch_id', 'data', 'branches', 'loan_officer_id', 'loan_product_id', 'loan_products', 'users', 'status'));
    }
}
