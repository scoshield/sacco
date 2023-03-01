<?php

namespace Modules\User\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Loan\Entities\LoanTransaction;
use Modules\Savings\Entities\SavingsTransaction;
use Modules\Core\Entities\PaymentDetail;
use Modules\Income\Entities\Income;
use Modules\Expense\Entities\Expense;

class Register extends Model
{
    protected $fillable = ['code', 'user_id', 'status', 'notes', 'approved', 'closed_by_user_id', 'approved_by_user_id', 'approval_notes', 'closing_notes', 'closing_time', 'opening_notes', 'approval_time'];

    public function user(){
        return $this->belongsTo(User::class);
    }

     public function latestRegister()
    {
        return $this->hasOne(Register::class)->latestOfMany();
    }

    public function registers()
    {
        return $this->hasMany(Register::class);
    }

    public function loan_transactions()
    {
        return $this->hasMany(LoanTransaction::class);
    }

    public function income(){
        return $this->hasMany(Income::class);
    }

    public function expenses()
    {
        return $this->hasMany(Expense::class);
    }

    public function savings_transactions()
    {
        return $this->hasMany(SavingsTransaction::class);
    }

    public function payment_details()
    {
        return $this->hasMany(PaymentDetail::class);
    }

    // public function ()

}
