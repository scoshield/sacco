<?php

namespace Modules\Expense\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Accounting\Entities\ChartOfAccount;
use Modules\Branch\Entities\Branch;
use Modules\User\Entities\User;
use Modules\Client\Entities\Group;
use Modules\User\Entities\Register;
use Modules\Core\Entities\Currency;
use Modules\Core\Entities\PaymentType;

class Expense extends Model
{
    protected $table = 'expenses';
    protected $fillable = [];

    public function asset_chart()
    {
        return $this->hasOne(ChartOfAccount::class, 'id', 'asset_chart_of_account_id');
    }

    public function expense_chart()
    {
        return $this->hasOne(ChartOfAccount::class, 'id', 'expense_chart_of_account_id');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class, 'branch_id', 'id');
    }

    public function register()
    {
        return $this->belongsTo(Register::class, 'register_id', 'id');
    }

    public function group()
    {
        return $this->belongsTo(Group::class, 'group_id', 'id');
    }
    public function created_by()
    {
        return $this->hasOne(User::class, 'id', 'created_by_id');
    }

    public function expense_type()
    {
        return $this->hasOne(ExpenseType::class, 'id', 'expense_type_id');
    }

    public function currency()
    {
        return $this->belongsTo(Currency::class, 'currency_id');
    }

    public function payment_method()
    {
        return $this->belongsTo(PaymentType::class, 'payment_type_id');
    }

}
