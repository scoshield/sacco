<?php

namespace Modules\Savings\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use Modules\Branch\Entities\Branch;
use Modules\Client\Entities\Client;
use Modules\Client\Entities\Group;
use Modules\Savings\Entities\Savings;
use Modules\Savings\Entities\SavingsProduct;
use Modules\Savings\Entities\SavingsTransaction;
use Modules\Savings\Exports\SavingsExport;
use Modules\User\Entities\User;
use PDF;

class ReportController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
        $this->middleware(['permission:savings.savings.reports.transactions'])->only(['transaction']);
        $this->middleware(['permission:savings.savings.reports.balances'])->only(['balance']);
        $this->middleware(['permission:savings.savings.reports.accounts'])->only(['account']);

    }

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        return theme_view('savings::report.index');
    }


    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function transaction(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $client_id = $request->client_id;
        $group_id = $request->group_id;
        $savings_product_id = $request->savings_product_id;
        $data = [];
        $branches = Branch::all();
        $clients = Client::all();
        $groups = Group::all();
        $savings_products = SavingsProduct::where('active', 1)->get();
        if (!empty($start_date)) {
            $data = DB::table("savings_transactions")
                ->join("savings", "savings_transactions.savings_id", "savings.id")
                ->join("savings_products", "savings.savings_product_id", "savings_products.id")
                ->join("branches", "savings.branch_id", "branches.id")
                ->join("clients", "savings.client_id", "clients.id")
                ->leftJoin("payment_details", "savings_transactions.payment_detail_id", "payment_details.id")
                ->leftJoin("users", "savings.savings_officer_id", "users.id")
                ->leftJoin("payment_types", "payment_details.payment_type_id", "payment_types.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('savings_transactions.submitted_on', [$start_date, $end_date]);
                })->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('savings_transactions.branch_id', $branch_id);
                })->when($savings_product_id, function ($query) use ($savings_product_id) {
                    $query->where('savings.savings_product_id', $savings_product_id);
                })->when($client_id, function ($query) use ($client_id) {
                    $query->where('savings.client_id', $client_id);
                })->when($group_id, function ($query) use ($group_id) {
                    $query->where('savings.group_id', $group_id);
                })->where('savings_transactions.reversed', 0)
                ->selectRaw("clients.first_name,clients.last_name,concat(users.first_name,' ',users.last_name) savings_officer,branches.name branch,payment_details.receipt,payment_types.name payment_type,savings_products.name savings_product,savings_transactions.id,savings_transactions.name transaction_type,savings_transactions.amount,savings_transactions.credit,savings_transactions.debit,savings_transactions.balance,savings_transactions.submitted_on,savings.id savings_id")
                ->get();

            // return $data;
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('savings::report.transaction_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'group_id', 'groups'));
                    return $pdf->download(trans_choice('savings::general.transaction', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('savings::report.transaction_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'group_id', 'groups'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.transaction', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.transaction', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.transaction', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('savings::report.transaction',
            compact('start_date',
                'end_date', 'branch_id', 'savings_product_id', 'client_id', 'data', 'branches', 'clients', 'savings_products', 'group_id', 'groups'));
    }

    public function account_statement(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $group_id = $request->group_id;
        $client_id = $request->client_id;
        $savings_id = $request->savings_id;
        $clients = Client::all();
        $savings = Savings::all();
        $groups = Group::all();
        $data = [];
        $branches = Branch::all();
        if (!empty($start_date)) {
            $data = SavingsTransaction::join("savings", "savings_transactions.savings_id", "savings.id")
                ->join("savings_products", "savings.savings_product_id", "savings_products.id")
                ->join("branches", "savings.branch_id", "branches.id")
                ->join("clients", "savings.client_id", "clients.id")
                ->leftJoin("payment_details", "savings_transactions.payment_detail_id", "payment_details.id")
                ->leftJoin("users", "savings.savings_officer_id", "users.id")
                ->leftJoin("payment_types", "payment_details.payment_type_id", "payment_types.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('savings_transactions.submitted_on', [$start_date, $end_date]);
                })
                ->when($client_id, function ($query) use ($client_id) {
                    $query->where('savings.client_id', $client_id);
                })
                ->when($savings_id, function ($query) use ($savings_id) {
                    $query->where('savings.id', $savings_id);
                })
                ->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('savings.branch_id', $branch_id);
                })
                ->when($group_id, function ($query) use ($group_id) {
                    $query->where('savings.group_id', $group_id);
                })
                ->where('savings_transactions.reversed', 0)
                ->selectRaw("concat(clients.first_name,' ',clients.last_name) client,concat(users.first_name,' ',users.last_name) savings_officer,branches.name branch,payment_details.receipt,payment_types.name payment_type,savings_products.name savings_product,savings_transactions.id,savings_transactions.name transaction_type,savings_transactions.amount,savings_transactions.credit,savings_transactions.debit,savings_transactions.balance,savings_transactions.submitted_on,savings.id savings_id,savings.account_number savings_account_number")
                ->get();
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('savings::report.account_statement_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'groups', 'group_id'));
                    return $pdf->download(trans_choice('savings::general.account_statement', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('savings::report.transaction_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'groups', 'group_id'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.account_statement', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.account_statement', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.account_statement', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('savings::report.account_statement',
            compact('start_date',
                'end_date', 'branch_id', 'data', 'branches', 'clients', 'client_id', 'savings_id','savings', 'groups', 'group_id'));
    }

    public function account(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $group_id = $request->group_id;
        $savings_officer_id = $request->savings_officer_id;
        $savings_product_id = $request->savings_product_id;
        $data = [];
        $branches = Branch::all();
        $groups = Group::all();
        $savings_products = SavingsProduct::where('active', 1)->get();
        $users = User::whereHas('roles', function ($query) {
            return $query->where('name', '!=', 'client');
        })->get();
        if (!empty($start_date)) {
            $data = DB::table("savings")
                ->leftJoin("savings_transactions", "savings_transactions.savings_id", "savings.id")
                ->join("savings_products", "savings.savings_product_id", "savings_products.id")
                ->join("branches", "savings.branch_id", "branches.id")
                ->join("clients", "savings.client_id", "clients.id")
                ->leftJoin("users", "savings.savings_officer_id", "users.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('savings.submitted_on_date', [$start_date, $end_date]);
                })->when($branch_id, function ($query) use ($branch_id) {
                    $query->where('savings.branch_id', $branch_id);
                })->when($savings_officer_id, function ($query) use ($savings_officer_id) {
                    $query->where('savings.savings_officer_id', $savings_officer_id);
                })
                ->when($group_id, function ($query) use ($group_id) {
                    $query->where('savings.group_id', $group_id);
                })
                ->selectRaw("clients.first_name,clients.middle_name,clients.last_name,concat(users.first_name,' ',users.last_name) savings_officer,branches.name branch,savings_products.name savings_product,clients.gender,sum(savings_transactions.credit) credit,sum(savings_transactions.debit) debit,savings.balance_derived balance,savings.submitted_on_date,savings.id id")
                ->groupBy('savings.client_id')
                ->get();

                // return $data;
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('savings::report.account_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'savings_products', 'users', 'savings_officer_id', 'savings_product_id', 'groups', 'group_id'));
                    return $pdf->download(trans_choice('savings::general.account', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('savings::report.account_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'savings_products', 'users', 'savings_officer_id', 'savings_product_id', 'groups', 'group_id'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.account', 1) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.account', 1) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.account', 1) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('savings::report.account',
            compact('start_date',
                'end_date', 'branch_id', 'data', 'branches', 'savings_products', 'users', 'savings_officer_id', 'savings_product_id', 'groups', 'group_id'));
    }

    public function balance(Request $request)
    {
        $start_date = $request->start_date;
        $end_date = $request->end_date;
        $branch_id = $request->branch_id;
        $group_id = $request->group_id;
        $savings_officer_id = $request->savings_officer_id;
        $savings_product_id = $request->savings_product_id;
        $data = [];
        $branches = Branch::all();
        $groups = Group::all();
        $savings_products = SavingsProduct::where('active', 1)->get();
        $users = User::whereHas('roles', function ($query) {
            return $query->where('name', '!=', 'client');
        })->get();
        if (!empty($start_date)) {
            $data = DB::table("savings_transactions")
                ->join("savings", "savings_transactions.savings_id", "savings.id")
                ->join("savings_products", "savings.savings_product_id", "savings_products.id")
                ->join("branches", "savings.branch_id", "branches.id")
                ->leftJoin("users", "savings.savings_officer_id", "users.id")
                ->when($start_date, function ($query) use ($start_date, $end_date) {
                    $query->whereBetween('savings_transactions.submitted_on', [$start_date, $end_date]);
                })->when($branch_id, function ($query) use ($branch_id) {
                    if($branch_id == null)
                    { 
                        $query->where('savings.branch_id', $branch_id);
                    }
                })
                ->when($savings_officer_id, function ($query) use ($savings_officer_id) {
                    $query->where('savings.savings_officer_id', $savings_officer_id);
                })
                ->when($group_id, function ($query) use ($group_id) {
                    $query->where('savings.group_id', $group_id);
                })
                ->selectRaw("concat(users.first_name,' ',users.last_name) savings_officer,branches.name branch,savings_products.name savings_product, credit, debit,savings_transactions.submitted_on")
                ->get();
            //check if we should download
            if ($request->download) {
                if ($request->type == 'pdf') {
                    $pdf = PDF::loadView(theme_view_file('savings::report.balance_pdf'), compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'savings_products', 'users', 'savings_officer_id', 'savings_product_id', 'groups', 'group_id'));
                    return $pdf->download(trans_choice('savings::general.account', 1) . '(' . $start_date . ' to ' . $end_date . ').pdf');
                }
                $view = theme_view('savings::report.balance_pdf',
                    compact('start_date',
                        'end_date', 'branch_id', 'data', 'branches', 'savings_products', 'users', 'savings_officer_id', 'savings_product_id', 'groups', 'group_id'));
                if ($request->type == 'excel_2007') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.balance', 2) . '(' . $start_date . ' to ' . $end_date . ').xlsx');
                }
                if ($request->type == 'excel') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.balance', 2) . '(' . $start_date . ' to ' . $end_date . ').xls');
                }
                if ($request->type == 'csv') {
                    return Excel::download(new SavingsExport($view), trans_choice('savings::general.balance', 2) . '(' . $start_date . ' to ' . $end_date . ').csv');
                }
            }
        }
        return theme_view('savings::report.balance',
            compact('start_date',
                'end_date', 'branch_id', 'data', 'branches', 'savings_products', 'users', 'savings_officer_id', 'savings_product_id', 'groups', 'group_id'));
    }
}
