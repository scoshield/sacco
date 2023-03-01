<?php

namespace Modules\Loan\Entities;

use Illuminate\Database\Eloquent\Model;

class LoanProduct extends Model
{
    protected $fillable = [];
    public $table = "loan_products";

    protected function getRepaymentFrequencyTypeAttribute($value)
    {
        return ucfirst($value);
    }

    public function charges()
    {
        return $this->hasMany(LoanProductLinkedCharge::class, 'loan_product_id', 'id');
    }

    public function loans()
    {
        return $this->hasMany(Loan::class);
    }
}
