<?php

namespace Modules\Loan\Entities;

use Illuminate\Database\Eloquent\Model;

class LoanLinkedCharge extends Model
{
    protected $fillable = [];
    public $table = "loan_linked_charges";

    public function charge()
    {
        return $this->hasOne(LoanCharge::class, 'id', 'loan_charge_id');
    }

    public function charge_type()
    {
        return $this->hasOne(LoanChargeType::class, 'id', 'loan_charge_type_id');
    }

    public function charge_option()
    {
        return $this->hasOne(LoanChargeOption::class, 'id', 'loan_charge_option_id');
    }

    public function loan()
    {
        return $this->hasOne(Loan::class, 'id', 'loan_id');
    }

    public function transaction()
    {
        return $this->hasOne(LoanTransaction::class, 'id', 'loan_transaction_id');
    }
}
