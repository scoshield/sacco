<?php

namespace Modules\Loan\Imports;

use Illuminate\Http\Request;
use Modules\Loan\Entities\LoanProduct;
use Modules\Loan\Entities\Loan;
use Modules\Client\Entities\Client;
use Modules\Client\Entities\Group;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Modules\Loan\Events\LoanStatusChanged;
use Modules\Loan\Events\TransactionUpdated;
use Modules\User\Entities\Register;
use Modules\Core\Entities\PaymentDetail;
use Modules\Core\Entities\PaymentType;
use Modules\Accounting\Entities\JournalEntry;
use Modules\Loan\Entities\LoanTransaction;
use Modules\Loan\Entities\LoanProcessingStrategy;
use Modules\Client\Http\Controllers\Api\v1\ClientController;
use Modules\Loan\Entities\LoanRepaymentSchedule;
use Carbon\Carbon;
use Modules\Loan\Entities\LoanHistory;
use Modules\Loan\Entities\LoanOfficerHistory;

class LoanImport implements ToCollection, WithHeadingRow
{
    private $request;
    private $group_id;
    private $created_by_id;

    public function __construct($id)
    {
        $this->group_id = $id;
    }
    
     /**
     * @param array $row
     *
     * @return ClientImport|null
     */
    public function collection(Collection $rows)
    {
       foreach($rows as $row)
       {
            try {
                DB::beginTransaction();                
            
                $client_id = $row['client_id'];
                $pap_amount = $row['pap_loan'];
                $pap_term = $row['pap_period'];
                $nawiri_amount = $row['nawiri_loan'];
                $nawiri_term = $row['nawiri_period'];

                if($pap_amount > 0)
                {
                    // create pap loan
                    $pap_id = $this->create_loan($client_id, 2, $pap_amount, $pap_term);
                    // return $pap_id;
                    // approve pap loan
                    $this->approve_loan($pap_id, $pap_amount);
                    // // disburse pap loan
                    $this->disburse_loan($pap_id);
                }

                if($nawiri_amount > 0)
                {
                    // create nawiri loan
                    $nawiri_id = $this->create_loan($client_id, 1, $nawiri_amount, $nawiri_term);
                    // approve NAWIRI loan
                    $this->approve_loan($nawiri_id, $nawiri_amount);
                    // disburse NAWIRI loan
                    $this->disburse_loan($nawiri_id);
                }

                DB::commit();
            } 
            // catch (\Exception $e) 
            // {
            // //throw $th;
                // DB::rollBack();
            // }
            catch (\Maatwebsite\Excel\Validators\ValidationException $e) {
                $failures = $e->failures();
                DB::rollBack();
                
                foreach ($failures as $failure) {
                    $failure->row(); // row that went wrong
                    $failure->attribute(); // either heading key (if using heading row concern) or column index
                    $failure->errors(); // Actual error messages from Laravel validator
                    $failure->values(); // The values of the row that has failed.
                }
           }
       }
    }

    /**
     * @param array $row
     *
     * @return ClientImport|null
     */
    // Activate the client savings account 1 and 2
    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function create_loan($client_id, $loan_product_id, $amount, $term)
    {
        
            $loan_product = LoanProduct::find($loan_product_id);       
            $client = Client::find($client_id);

           try{
                $loan = new Loan();
                $loan->currency_id = $loan_product->currency_id;
                $loan->loan_product_id = $loan_product->id;
                $loan->client_id = $client->id;
                $loan->group_id = $client->group_id;
                $loan->branch_id = $client->branch_id;
                $loan->loan_transaction_processing_strategy_id = $loan_product->loan_transaction_processing_strategy_id;
                $loan->loan_purpose_id = 1;
                $loan->loan_officer_id = Auth::id();
                $loan->expected_disbursement_date = Carbon::createFromDate(2022, 8, 1);
                $loan->expected_first_payment_date = Carbon::createFromDate(2022, 8, 31);
                $loan->fund_id = 1;
                $loan->created_by_id = Auth::id();
                $loan->applied_amount = $amount;
                $loan->loan_term = $term;
                $loan->repayment_frequency = $loan_product->repayment_frequency;
                $loan->repayment_frequency_type = $loan_product->repayment_frequency_type;
                $loan->interest_rate = $loan_product->default_interest_rate;
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

                //  create a loan history
            
                $loan_history = new LoanHistory();
                $loan_history->loan_id = $loan->id;
                $loan_history->created_by_id = Auth::id();
                $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
                $loan_history->action = 'Loan Import';
                $loan_history->save();
                $loan_officer_history = new LoanOfficerHistory();
                $loan_officer_history->loan_id = $loan->id;
                $loan_officer_history->created_by_id = Auth::id();
                $loan_officer_history->loan_officer_id = Auth::id();
                $loan_officer_history->start_date = date("Y-m-d");
                $loan_officer_history->save();
                // custom_fields_save_form('add_loan', $request, $loan->id);
                //fire loan status changed event
                event(new LoanStatusChanged($loan));
                return $loan->id;

           } catch ( \Exception $e )
           {
                return response()->json($e);
           }
    }    

    public function approve_loan($loan_id, $amount)
    {
        $loan = Loan::find($loan_id);
        $previous_status = $loan->status;
        $loan->approved_by_user_id = Auth::id();
        $loan->approved_amount = $amount;
        $loan->approved_on_date = date('Y-m-d');
        $loan->status = 'approved';
        $loan->approved_notes = 'Initial Import';
        $loan->save();

        $loan_history = new LoanHistory();
        $loan_history->loan_id = $loan->id;
        $loan_history->created_by_id = Auth::id();
        $loan_history->user = Auth::user()->first_name . ' ' . Auth::user()->last_name;
        $loan_history->action = 'Loan Import Approved';
        $loan_history->save();
        //fire loan status changed event
        event(new LoanStatusChanged($loan, $previous_status));
                    
    }


    public function disburse_loan($loan_id)
    {
        $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;
        $loan = Loan::find($loan_id);

            $payment_detail = new PaymentDetail();
            $payment_detail->created_by_id = Auth::id();
            $payment_detail->payment_type_id = 5;
            $payment_detail->amount = $loan->approved_amount;
            $payment_detail->register_id = $reg_id;
            $payment_detail->group_id = $loan->group_id;
            $payment_detail->reference = $loan->id;
            $payment_detail->transaction_type = 'loan_transaction';
            $payment_detail->cheque_number = '';
            $payment_detail->receipt = '';
            $payment_detail->account_number = '';
            $payment_detail->bank_name = '';
            $payment_detail->routing_code = '';
            $payment_detail->save();

            $previous_status = $loan->status;
            $loan->approved_by_user_id = Auth::id();
            $loan->disbursed_on_date = $loan->expected_disbursement_date;
            $loan->first_payment_date = $loan->expected_first_payment_date;
            $loan->principal = $loan->approved_amount;
            $loan->status = 'active';

            //prepare loan schedule
            //determine interest rate
            $interest_rate = determine_period_interest_rate($loan->interest_rate, $loan->repayment_frequency_type, $loan->interest_rate_type);
            $balance = round($loan->principal, $loan->decimals);
            $period = ($loan->loan_term / $loan->repayment_frequency);
            $payment_from_date = $loan->expected_disbursement_date;
            $next_payment_date = Carbon::parse($payment_from_date)->add($loan->repayment_frequency, $loan->repayment_frequency_type)->format("Y-m-d");
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
            $loan_history->action = 'Loan Import Disbursed';
            $loan_history->save();
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
            $loan_transaction->amount = $loan->principal;
            $loan_transaction->debit = $loan->principal;
            $disbursal_transaction_id = $loan_transaction->id;
            $loan_transaction->save();
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

            $loan->save();
            //check if accounting is enabled
            if ($loan->loan_product->accounting_rule == "cash" || $loan->loan_product->accounting_rule == "accrual_periodic" || $loan->loan_product->accounting_rule == "accrual_upfront") {
                //loan disbursal
                //credit account
                $journal_entry = new JournalEntry();
                $journal_entry->created_by_id = Auth::id();
                $journal_entry->payment_detail_id = $payment_detail->id;
                $journal_entry->transaction_number = 'L' . $disbursal_transaction_id;
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
                $journal_entry->transaction_number = 'L' . $disbursal_transaction_id;
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
            }
            //fire loan status changed event
            event(new LoanStatusChanged($loan, $previous_status));
            // return response()->json(['data' => $loan, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
        
    }
   
}
