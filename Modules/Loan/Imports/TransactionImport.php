<?php

namespace Modules\Loan\Imports;

use Illuminate\Http\Request;
use Modules\Loan\Entities\LoanProduct;
use Modules\Loan\Entities\Loan;
use Modules\Savings\Entities\Savings;
use Modules\Client\Entities\Client;
use Modules\Client\Entities\Group;
use Modules\Income\Entities\Income;
use Modules\Income\Entities\IncomeType;
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
use Modules\Savings\Entities\SavingsTransaction;
use Modules\Loan\Entities\LoanRepaymentSchedule;
use Carbon\Carbon;
use Modules\Loan\Entities\LoanHistory;
use Modules\Loan\Entities\LoanOfficerHistory;

class TransactionImport implements ToCollection, WithHeadingRow
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
                    $nawiri_savings = $row['savings_1'];
                    $akiba_savings = $row['savings_2'];
                    $nawiri_loan = $row['loan_1'];
                    $pap_loan = $row['loan_2'];
                    $passbook = $row['income_1'];
                    $hall = $row['income_2'];
                    $fines = $row['income_3'];
                    $date = \PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($row['trans_date'])->format('Y-m-d');
                    $payment_type = $row['payment_type'];
                    $trans_ref = $row['trans_ref'];

                    // save the transaction records
                    // var_dump($date);
                    if($nawiri_savings > 0)
                    {
                        $this->savings_repayment(1, $nawiri_savings, $client_id, $date, $payment_type, $trans_ref);
                    }

                    if($akiba_savings > 0)
                    {
                        $this->savings_repayment(2, $akiba_savings, $client_id, $date, $payment_type, $trans_ref);
                    }

                    // save the loan transactions
                    if($nawiri_loan > 0)
                    {
                        $this->loan_repayments($client_id, 1, $nawiri_loan, $date, $payment_type, $trans_ref);
                    }

                    if($pap_loan > 0)
                    {
                        $this->loan_repayments($client_id, 2, $pap_loan, $date, $payment_type, $trans_ref);
                    }

                    // save the incomes
                    if($passbook > 0)
                    {
                        $this->income_collection(1, $passbook, $date, $payment_type, $trans_ref);
                    }
                    if($hall > 0)
                    {
                        $this->income_collection(2, $hall, $date, $payment_type, $trans_ref);
                    }
                    if($fines > 0)
                    {
                        $this->income_collection(3, $fines, $date, $payment_type, $trans_ref);
                    }

                DB::commit();
            } 
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

    // import the client savings transactions
    public function savings_repayment($id, $amount, $client_id, $date, $payment_type, $trans_ref)
    {
        // find the savings id
        $saving = Savings::where('savings_product_id', $id)->where('client_id', $client_id)->first();
        // app('Modules\Client\Imports\ClientImport')->savings_transaction($id, $amount, $date, $payment_type, $trans_ref);

        // $saving = Savings::with('savings_product')->find($saving_id);
        $reg_id = Register::where('user_id', Auth::id())->where('status', 'active')->first()->id;
    
        $payment_detail = new PaymentDetail();
        $payment_detail->created_by_id = Auth::id();
        $payment_detail->payment_type_id = $payment_type;
        $payment_detail->amount = $amount;
        $payment_detail->group_id = $saving->group_id;
        $payment_detail->branch_id = $saving->branch_id;
        $payment_detail->reference = $saving->id;
        $payment_detail->payment_date = $date;
        $payment_detail->transaction_type = 'savings_transaction';
        $payment_detail->cheque_number = null;
        $payment_detail->receipt = 'IMPORT '.date('Y-m-d').' - '.$trans_ref;
        $payment_detail->register_id = $reg_id;
        $payment_detail->account_number = null;
        $payment_detail->bank_name = null;
        $payment_detail->routing_code = null;
        $payment_detail->save();

        $savings_transaction = new SavingsTransaction();
        $savings_transaction->created_by_id = Auth::id();
        $savings_transaction->savings_id = $saving->id;
        $savings_transaction->branch_id = $saving->branch_id;
        $savings_transaction->group_id = $saving->group_id;
        $savings_transaction->register_id = $reg_id;
        $savings_transaction->payment_detail_id = $payment_detail->id;
        $savings_transaction->name = trans_choice('savings::general.deposit', 1);
        $savings_transaction->savings_transaction_type_id = 1;
        $savings_transaction->submitted_on = $date;
        $savings_transaction->created_on = $date;
        $savings_transaction->reversible = 1;
        $savings_transaction->amount = $amount;
        $savings_transaction->credit = $amount;
        $savings_transaction->save();
        if ($saving->savings_product->accounting_rule == 'cash') {
            //debit account
            $journal_entry = new JournalEntry();
            $journal_entry->created_by_id = Auth::id();
            $journal_entry->transaction_number = 'S' . $savings_transaction->id;
            $journal_entry->branch_id = $saving->branch_id;
            $journal_entry->currency_id = $saving->currency_id;
            if(PaymentType::find($payment_detail->payment_type_id)->is_cash == 1)
            {
                $journal_entry->chart_of_account_id = Auth::user()->user_control_account;
            }else{
                $journal_entry->chart_of_account_id = $savings->savings_product->savings_reference_chart_of_account_id;
            }
            $journal_entry->transaction_type = 'savings_deposit';
            $journal_entry->date = $date;
            $date1 = explode('-', $date);
            $journal_entry->month = $date1[1];
            $journal_entry->year = $date1[0];
            $journal_entry->debit = $savings_transaction->amount;
            $journal_entry->reference = $saving->id;
            $journal_entry->save();
            //credit account
            $journal_entry = new JournalEntry();
            $journal_entry->created_by_id = Auth::id();
            $journal_entry->transaction_number = 'S' . $savings_transaction->id;
            $journal_entry->branch_id = $saving->branch_id;
            $journal_entry->currency_id = $saving->currency_id;
            $journal_entry->chart_of_account_id = $saving->savings_product->savings_control_chart_of_account_id;
            $journal_entry->transaction_type = 'savings_deposit';
            $journal_entry->date = $date;
            $date1 = explode('-', $date);
            $journal_entry->month = $date1[1];
            $journal_entry->year = $date1[0];
            $journal_entry->credit = $amount;
            $journal_entry->reference = $saving->id;
            $journal_entry->save();
        }
        activity()->on($saving)
            ->withProperties(['id' => $saving->id])
            ->log('Create Savings Deposit');
        //fire transaction updated event
        event(new \Modules\Savings\Events\TransactionUpdated($saving));
        \flash(trans_choice("core::general.successfully_saved", 1))->success()->important();
    }

    // import the client loan repayments
    public function loan_repayments($client_id, $loan_product_id, $amount, $date, $payment_type, $trans_ref)
    {       
        // Client loan
            $loan = Loan::with('loan_product')->where('loan_product_id', $loan_product_id)->where('client_id', $client_id)->first();           
            $register = Register::where('user_id', Auth::id())->where('status', 'active')->first();

            $payment_detail = new PaymentDetail();
            $payment_detail->created_by_id = Auth::id();
            // $current['payment_type_id]
            $payment_detail->payment_type_id = $payment_type;
            $payment_detail->amount = $amount;
            $payment_detail->group_id = $loan->group_id;
            $payment_detail->branch_id = $loan->branch_id;
            $payment_detail->transaction_type = 'loan_transaction';
            $payment_detail->reference = $loan->id;
            $payment_detail->cheque_number = null;
            $payment_detail->payment_date = $date;
            //  $current['receipt']
            $payment_detail->receipt = $trans_ref;
            $payment_detail->register_id = $register->id;
            $payment_detail->account_number = null;
            $payment_detail->bank_name = null;
            $payment_detail->routing_code = null;
            $payment_detail->description = 'Repayment import';
            $payment_detail->save();
            // LOAN TRANSACTION
            $loan_transaction = new LoanTransaction();
            $loan_transaction->created_by_id = Auth::id();
            $loan_transaction->register_id = $register->id;
            $loan_transaction->group_id = $loan->group_id;
            $loan_transaction->branch_id = $loan->branch_id;
            $loan_transaction->created_on = $loan->date;
            // $currloans['loan_id']
            $loan_transaction->loan_id = $loan->id;
            $loan_transaction->payment_detail_id = $payment_detail->id;
            $loan_transaction->name = trans_choice('loan::general.repayment', 1);
            $loan_transaction->loan_transaction_type_id = 2;
            $loan_transaction->submitted_on = $date;
            $loan_transaction->created_on = $date;
            // $min
            $loan_transaction->amount = $amount;
            $loan_transaction->credit = $amount;
            $loan_transaction->save();

            activity()->on($loan_transaction)
                ->withProperties(['id' => $loan_transaction->id])
                ->log('Create Loan Repayment');
            //fire transaction updated event
            event(new TransactionUpdated($loan));

            // create a new repayment schedule
            app('Modules\Loan\Http\Controllers\Api\v1\LoanController')->create_repayment_schedule($loan->id, $loan_transaction->amount);
    }

    // import the client income payments
    public function income_collection($income_type, $amount, $date, $payment_type, $trans_ref)
    {
        $register = Register::where('user_id', Auth::id())->where('status', 'active')->first();
        // CREATE NEW INCOME
        $income = new Income();
        $income->created_by_id = Auth::id();
        $income->income_type_id = $income_type;
        $income->currency_id = 3;
        $income->branch_id = Group::find($this->group_id)->branch_id;
        $income->group_id = $this->group_id;
        $income->register_id = $register->id;
        $income->income_chart_of_account_id = IncomeType::find($income_type)->income_chart_of_account_id;
        $income->asset_chart_of_account_id = IncomeType::find($income_type)->asset_chart_of_account_id;
        $income->amount = $amount;
        $income->date = $date;
        $income->description = IncomeType::find($income_type)->name;
        $income->save();

        // CAPTURE INCOME PAYMENT DETAILS
        $payment_detail = new PaymentDetail();
        $payment_detail->created_by_id = Auth::id();
        $payment_detail->payment_type_id = $payment_type;
        $payment_detail->amount = $amount;
        $payment_detail->group_id = $this->group_id;
        $payment_detail->branch_id = Group::find($this->group_id)->branch_id;
        $payment_detail->payment_date = $date;
        $payment_detail->register_id = $register->id;
        $payment_detail->transaction_type = 'income';
        $payment_detail->reference = $income->id;
        $payment_detail->cheque_number = null;
        $payment_detail->receipt = $trans_ref;
        $payment_detail->account_number = null;
        $payment_detail->bank_name = null;
        $payment_detail->routing_code = null;
        $payment_detail->description = 'Income import';
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
            if(PaymentType::find($payment_type)->is_cash == 1)
            {
                $journal_entry->chart_of_account_id = Auth::user()->user_control_account;
            }else{
                $journal_entry->chart_of_account_id = PaymentType::find($payment_type)->asset_control_account;
            }
            $journal_entry->transaction_type = 'income';
            $journal_entry->date = Carbon::parse($date)->format('Y-m-d');
            $date1 = explode('-', Carbon::parse($date)->format('Y-m-d'));
            $journal_entry->month = $date1[1];
            $journal_entry->year = $date1[0];
            $journal_entry->debit = $income->amount;
            $journal_entry->reference = $income->id;
            $journal_entry->notes = 'Income import';
            $journal_entry->save();
        }
        // credit
        if (!empty($income->asset_chart_of_account_id)) {
            $journal_entry = new JournalEntry();
            $journal_entry->created_by_id = Auth::id();
            $journal_entry->payment_detail_id = $payment_detail->id;
            $journal_entry->transaction_number = $income->id;
            $journal_entry->branch_id = $income->branch_id;
            $journal_entry->currency_id = $income->currency_id;
            $journal_entry->chart_of_account_id = $income->income_chart_of_account_id;
            $journal_entry->transaction_type = 'income';
            $journal_entry->date = $date;;
            $date1 = explode('-', $date);
            $journal_entry->month = $date1[1];
            $journal_entry->year = $date1[0];
            $journal_entry->credit = $income->amount;
            $journal_entry->reference = $income->id;
            $journal_entry->notes = 'Income import';
            $journal_entry->save();
        }
    }

}