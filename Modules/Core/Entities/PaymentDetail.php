<?php

namespace Modules\Core\Entities;

use Illuminate\Database\Eloquent\Model;

class PaymentDetail extends Model
{
    protected $table = "payment_details";
    protected $fillable = ['reference', 'created_by_id', 'expense_type_id', 'payment_type_id',
    'amount',
    'group_id',
    'transaction_type',
    'cheque_number',
    'receipt',
    'account_number',
    'bank_name',
    'branch_id',
    'payment_date',
    'description',
    'routing_code',];

    public function payment_type()
    {
        return $this->hasOne(PaymentType::class, 'id', 'payment_type_id');
    }
}
