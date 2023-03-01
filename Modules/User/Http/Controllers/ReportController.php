<?php

namespace Modules\User\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use Modules\Branch\Entities\Branch;
use Modules\Client\Entities\Client;
use Modules\Loan\Entities\Loan;
use Modules\Loan\Entities\LoanTransaction;
use Modules\Savings\Entities\Savings;
use Modules\Savings\Entities\SavingsProduct;
use Modules\User\Exports\UserExport;
use Modules\User\Entities\User;
use Modules\User\Entities\Register;
use PDF;

class ReportController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
        $this->middleware(['permission:user.reports.performance'])->only(['transaction']);
        $this->middleware(['permission:user.reports.index'])->only(['index']);
        $this->middleware(['permission:user.reports.accounts'])->only(['account']);

    }

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        return theme_view('user::report.index');
    }


    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function performance(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $loan_officer_id = $request->loan_officer_id;
        $data = [];
        $branches = Branch::all();
        $users = User::whereHas('roles', function ($query) {
            return $query->where('name', '!=', 'client');
        })->get();
        if (!empty($start_date)) {
            $number_of_clients = Client::where('loan_officer_id', $loan_officer_id)
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('created_at', [$start_date, $end_date]);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('branch_id', $branch_id);
                })
                ->count();
            $number_of_loans = Loan::where('loan_officer_id', $loan_officer_id)
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('created_at', [$start_date, $end_date]);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('branch_id', $branch_id);
                })
                ->count();
            $number_of_savings = Savings::where('savings_officer_id', $loan_officer_id)
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('created_at', [$start_date, $end_date]);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('branch_id', $branch_id);
                })
                ->count();
            $disbursed_loans_amount = Loan::where('loan_officer_id', $loan_officer_id)
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('disbursed_on_date', [$start_date, $end_date]);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('branch_id', $branch_id);
                })
                ->sum('principal');
            $total_payments_received = LoanTransaction::join("loans", "loan_transactions.loan_id", "loans.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('loan_transactions.submitted_on', [$start_date, $end_date]);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('loans.branch_id', $branch_id);
                })
                ->where('loan_officer_id', $loan_officer_id)
                ->where('loan_transaction_type_id', 2)
                ->sum('amount');
            $data = [
                'number_of_clients' => $number_of_clients,
                'number_of_loans' => $number_of_loans,
                'number_of_savings' => $number_of_savings,
                'disbursed_loans_amount' => $disbursed_loans_amount,
                'total_payments_received' => $total_payments_received,
            ];
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('user::report.performance_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches','users','loan_officer_id'));
                    return $pdf->download(trans_choice('user::general.performance_report', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('user::report.performance_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches','users','loan_officer_id'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.performance_report', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.performance_report', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.performance_report', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('user::report.performance',
            compact('start_date',
                'end_date', 'branch_id', 'data', 'branches', 'loan_officer_id', 'users'));
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function register(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $user_id = $request->user_id;
        $savings_product_id = $request->savings_product_id;
        $data = [];
        $branches = Branch::all();
        $users = User::all();
        $savings_products = SavingsProduct::where('active', 1)->get();
        if (!empty($start_date)) {
          
            $data = Register::with(['savings_transactions' => function($query) use ($start_date, $end_date){
                        $query->selectRaw('savings_transactions.*, SUM(savings_transactions.amount) total_savings');
                        $query->where('savings_transactions.name', 'Deposit');
                        $query->groupBy('savings_transactions.register_id');
                    }])
                    ->with(['income' => function($query){
                        $query->selectRaw('income.*, SUM(income.amount) total_incomes');
                        $query->groupBy('income.register_id');
                    }])
                    ->with(['expenses' => function($query){
                        $query->selectRaw('expenses.*, SUM(expenses.amount) total_expenses');
                        $query->groupBy('expenses.register_id');
                    }])
                    ->with(['user' => function($query){
                        $query->selectRaw('users.*');
                    }])
                    ->with(['loan_transactions' => function($query){
                        $query->selectRaw('loan_transactions.*, SUM(loan_transactions.amount) as total_loans');
                        $query->where('loan_transactions.name', 'Repayment');
                        $query->groupBy('loan_transactions.register_id');
                    }])  
                    ->when($user_id, function($query) use ($user_id){
                        $query->where('registers.user_id', $user_id);
                    })     
                    ->when($start_date, function ($query) use ($start_date, $end_date) {
                            $query->whereBetween('registers.created_at', [$start_date, $end_date]);
                        })            
                    ->get();

            // return response()->json($data);
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('user::report.register_pdf'), compact('start_date',
                        'end_date', 'user_id', 'data', 'branches'));
                    return $pdf->download(trans_choice('user::general.register', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('user::report.register_pdf',
                    compact('start_date',
                        'end_date', 'user_id', 'data', 'branches'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.register', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.register', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.register', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('user::report.register',
            compact('start_date',
                'end_date', 'branch_id', 'savings_product_id', 'user_id', 'data', 'branches', 'users', 'savings_products'));
    }


    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function detailed_register(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $user_id = $request->user_id;
        $register_id = $request->register_id;
        $savings_product_id = $request->savings_product_id;
        $data = [];
        $branches = Branch::all();
        $users = User::all();
        $savings_products = SavingsProduct::where('active', 1)->get();
        if (!empty($start_date)) {
          
            $data = Register::with(['savings_transactions' => function($query) use ($start_date, $end_date){
                        $query->selectRaw('savings_transactions.*, SUM(savings_transactions.amount) total_savings');
                        $query->where('savings_transactions.name', 'Deposit');
                        $query->groupBy('savings_transactions.register_id');
                    }])
                    ->with(['income' => function($query){
                        $query->selectRaw('income.*, SUM(income.amount) total_incomes');
                        $query->groupBy('income.register_id');
                    }])
                    ->with(['expenses' => function($query){
                        $query->selectRaw('expenses.*, SUM(expenses.amount) total_expenses');
                        $query->groupBy('expenses.register_id');
                    }])
                    ->with(['user' => function($query){
                        $query->selectRaw('users.*');
                    }])
                    ->with(['loan_transactions' => function($query){
                        $query->selectRaw('loan_transactions.*, SUM(loan_transactions.amount) as total_loans');
                        $query->where('loan_transactions.name', 'Repayment');
                        $query->groupBy('loan_transactions.register_id');
                    }])  
                    ->when($register_id, function($query) use ($register_id){
                        $query->where('registers.id', $register_id);
                    })     
                    ->when($start_date, function ($query) use ($start_date, $end_date) {
                            $query->whereBetween('registers.created_at', [$start_date, $end_date]);
                        })            
                    ->first();

            // return response()->json($data);
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('user::report.register_pdf'), compact('start_date',
                        'end_date', 'user_id', 'data', 'branches'));
                    return $pdf->download(trans_choice('user::general.register', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('user::report.register_pdf',
                    compact('start_date',
                        'end_date', 'user_id', 'data', 'branches'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.register', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.register', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new UserExport($view), trans_choice('user::general.register', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('user::report.detailed',
            compact('start_date',
                'end_date', 'branch_id', 'savings_product_id', 'user_id', 'data', 'branches', 'users', 'savings_products'));
    }

     /**
     * Display a listing of the resource.
     * @return Response
     */
    public function master(Request $request)
    {
        $perPage = $request->per_page ? $request->per_page : 20;
        $orderBy = $request->order_by;
        $orderByDir = $request->order_by_dir;
        $search = $request->s;
        $status = $request->status;
        $page = $request->page;
        $branch_id = $request->branch_id;
        $group_id = $request->group_id;
        $profession = $request->profession_id;
        $end_date = date('Y-m-d H:i:s');
        $data = Client::leftJoin("branches", "branches.id", "clients.branch_id")
            ->leftJoin("users", "users.id", "clients.loan_officer_id")
            ->leftJoin('client_groups', 'client_groups.id', 'clients.group_id')
            ->leftJoin("professions", "clients.profession_id", "professions.id")
            ->when($orderBy, function (Builder $query) use ($orderBy, $orderByDir) {
                $query->orderBy($orderBy, $orderByDir);
            })
            ->when($search, function (Builder $query) use ($search) {
                $query->where('clients.first_name', 'like', "%$search%");
                $query->orWhere('clients.middle_name', 'like', "%$search%");
                $query->orWhere('clients.last_name', 'like', "%$search%");
                $query->orWhere('clients.account_number', 'like', "%$search%");
                $query->orWhere('clients.mobile', 'like', "%$search%");
                $query->orWhere('clients.external_id', 'like', "%$search%");
                $query->orWhere('clients.email', 'like', "%$search%");
                $query->orWhere('client_groups.group_name', 'like', "%$search%");
            })
            ->when($status, function ($query) use ($status) {
                $query->where('clients.status', $status);
            })
            ->when($profession, function($query) use ($profession){
                $query->where('clients.profession_id', $profession);
            })
            ->when($branch_id, function($query) use ($branch_id){
                $query->where('clients.branch_id', $branch_id);
            })
            ->when($group_id, function($query) use ($group_id){
                $query->where('clients.group_id', $group_id);
            })
            ->selectRaw("branches.name branch,concat(users.first_name,' ',users.last_name) staff,clients.id,client_groups.group_name,clients.loan_officer_id,clients.first_name,clients.middle_name, clients.last_name,clients.gender,clients.mobile,professions.name profession, clients.email,clients.external_id,clients.status")
            ->paginate($perPage)
            ->appends($request->input());
            
            //check if we should download
            if ($request->download) {      
                $view = theme_view('client::report.download',
                    compact('data'));          
                if ($request->type == 'excel_2007') {
                    return Excel::download(new UserExport($view), trans_choice('client::general.client', 2) . '( Dimewise Clients ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new UserExport($view), trans_choice('client::general.client', 2) . '( Dimewise Clients ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new UserExport($view), trans_choice('client::general.client', 2) . '( Dimewise Clients ' . $end_date . ').csv');
                }
            }
            return theme_view('client::report.master', compact('data', 'perPage', 'page', 'search', 'branch_id'));
    }

}
