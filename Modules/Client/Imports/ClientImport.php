<?php

namespace Modules\Client\Imports;

use Illuminate\Http\Request;
use Modules\Savings\Entities\SavingsProduct;
use Modules\Savings\Entities\Savings;
use Modules\Client\Entities\Client;
use Modules\Client\Entities\Group;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Modules\Savings\Events\SavingsStatusChanged;
use Modules\Savings\Events\TransactionUpdated;
use Modules\User\Entities\Register;
use Modules\Core\Entities\PaymentDetail;
use Modules\Core\Entities\PaymentType;
use Modules\Accounting\Entities\JournalEntry;
use Modules\Savings\Entities\SavingsTransaction;
use Modules\Client\Entities\Profession;
use Modules\Client\Http\Controllers\Api\v1\ClientController;
use Carbon\Carbon;

class ClientImport implements ToCollection, WithHeadingRow
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

                $profession = Profession::updateOrCreate(["name" => $row["profession"]]);
                $client = Client::updateOrCreate(["mobile" => $row["mobile_number"], "external_id" => $row["id_card"]], [
                    // custom client values
                        'created_by_id' => Auth::id(),
                        // 'branch_id' => Group::find($this->group_id)->branch_id,
                        // 'group_id' => $this->group_id,
                        // 'activation_date' => date('Y-m-d'),
                        'is_official' => 0,
                        'country_id' => 3,
                        'status' => 'active',
                        // insert the PDF rows
                        'first_name'     => $row['first_name'],
                        'middle_name'    => $row['middle_name'], 
                        'last_name' => $row['last_name'],
                        'gender' => strtolower($row['gender']),
                        'marital_status' => strtolower($row['marital_status']),
                        'mobile' => $row['mobile_number'],
                        'email' => $row['email'],
                        'external_id' => $row['id_card'],
                        'dob' => $row['dob'],
                        'address' => $row['address'],
                        'city' => $row['city'],
                        'source_of_income' => $row['source_income'],
                        'profession_id' => $profession->id,
                        'years_of_experience' => $row['years_experience'],
                        'county' => $row['county'],
                        'joined_date' => $row['joined_date'],
                        // 'created_date' => date('Y-m-d'),
                        // activate savings account
                    ]);
                    // $savings1 = $this->activate_savings($client->id, 1, $row['savings_1']);
                    // $savings1a = $this->savings_transaction($savings1, $row['savings_1'], date('Y-m-d'));
            //         // var_dump($savings1);

                    // $savings2 = $this->activate_savings($client->id, 2, $row['savings_2']);
                    // $savings2a = $this->savings_transaction($savings2, $row['savings_2'], date('Y-m-d'));

                DB::commit();
            } catch (\Exception $e) 
            {
            //throw $th;
                DB::rollBack();
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
    public function activate_savings($client_id, $product_id, $opening_balance)
    {
        
            $savings_product = SavingsProduct::find($product_id);
       
            $client = Client::find($client_id);
            $savings = new Savings();
            $savings->currency_id = $savings_product->currency_id;
            $savings->created_by_id = Auth::id();
            $savings->client_id = $client_id;
            $savings->savings_product_id = $savings_product->id;
            $savings->savings_officer_id = Auth::id();
            $savings->branch_id = $client->branch_id;
            $savings->group_id = $client->group_id;
            $savings->interest_rate = $savings_product->default_interest_rate;
            $savings->interest_rate_type = $savings_product->interest_rate_type;
            $savings->compounding_period = $savings_product->compounding_period;
            $savings->interest_posting_period_type = $savings_product->interest_posting_period_type;
            $savings->decimals = $savings_product->decimals;
            $savings->interest_calculation_type = $savings_product->interest_calculation_type;
            // $savings->automatic_opening_balance = $request->automatic_opening_balance;
            $savings->lockin_period = $savings_product->lockin_period;
            $savings->lockin_type = $savings_product->lockin_type;
            $savings->allow_overdraft = $savings_product->allow_overdraft;
            $savings->overdraft_limit = $savings_product->overdraft_limit;
            $savings->overdraft_interest_rate = $savings_product->overdraft_interest_rate;
            $savings->minimum_overdraft_for_interest = $savings_product->minimum_overdraft_for_interest;
            $savings->automatic_opening_balance = $opening_balance;
            $savings->submitted_on_date = date('Y-m-d');
            $savings->submitted_by_user_id = Auth::id();
            $savings->status = 'active';
            $savings->activated_on_date = date('Y-m-d');
            $savings->activated_by_user_id = Auth::id();
            $savings->approved_on_date = date('Y-m-d');
            $savings->approved_by_user_id = Auth::id();
            $savings->save();
           
            custom_fields_save_form('add_savings', $savings, $savings->id);
            // return response()->json(['data' => $savings, "message" => trans_choice("core::general.successfully_saved", 1), "success" => true]);
            return $savings->id;
        // }
    }

    public function savings_transaction($saving_id, $amount, $date, $payment_type=5, $trans_ref=null)
    {
            $saving = Savings::with('savings_product')->find($saving_id);
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
                $date = explode('-', $date);
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
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
                $date = explode('-', $date);
                $journal_entry->month = $date[1];
                $journal_entry->year = $date[0];
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
    
}
