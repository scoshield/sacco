<?php

namespace Modules\Savings\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Branch\Entities\Branch;
use Modules\Client\Entities\Client;
use Modules\Core\Entities\Currency;
use Modules\User\Entities\User;
use Modules\Client\Entities\Group;

class Savings extends Model
{
    protected $fillable = [
        'currency_id',
        'created_by_id',
        'client_id',
        'savings_product_id',
        'savings_officer_id',
        'branch_id',
        'group_id',
        'interest_rate',
        'interest_rate_type',
        'compounding_period',
        'interest_posting_period_type',
        'decimals',
        'interest_calculation_type',
        'automatic_opening_balance',
        'lockin_period',
        'lockin_type',
        'allow_overdraft',
        'overdraft_limit',
        'overdraft_interest_rate',
        'minimum_overdraft_for_interest',
        'submitted_on_date',
        'submitted_by_user_id',
        'status',
        'activated_on_date',
        'activated_by_user_id',
        'approved_on_date',
        'approved_by_user_id',

    ];
    public $table = "savings";

    public function charges()
    {
        return $this->hasMany(SavingsLinkedCharge::class, 'savings_id', 'id');
    }

    public function savings_product()
    {
        return $this->belongsTo(SavingsProduct::class, 'savings_product_id', 'id');
    }

    public function client()
    {
        return $this->hasOne(Client::class, 'id', 'client_id');
    }

    public function branch()
    {
        return $this->hasOne(Branch::class, 'id', 'branch_id');
    }

    public function group()
    {
        return $this->hasOne(Group::class, 'id', 'group_id');
    }

    public function currency()
    {
        return $this->hasOne(Currency::class, 'id', 'currency_id');
    }

    public function savings_officer()
    {
        return $this->hasOne(User::class, 'id', 'savings_officer_id');
    }

    public function submitted_by()
    {
        return $this->hasOne(User::class, 'id', 'submitted_by_user_id');
    }

    public function approved_by()
    {
        return $this->hasOne(User::class, 'id', 'approved_by_user_id');
    }

    public function activated_by()
    {
        return $this->hasOne(User::class, 'id', 'activated_by_user_id');
    }

    public function rejected_by()
    {
        return $this->hasOne(User::class, 'id', 'rejected_by_user_id');
    }

    public function written_off_by()
    {
        return $this->hasOne(User::class, 'id', 'written_off_by_user_id');
    }

    public function closed_by()
    {
        return $this->hasOne(User::class, 'id', 'closed_by_user_id');
    }

    public function withdrawn_by()
    {
        return $this->hasOne(User::class, 'id', 'withdrawn_by_user_id');
    }

    public function dormant_by()
    {
        return $this->hasOne(User::class, 'id', 'dormant_by_user_id');
    }

    public function inactive_by()
    {
        return $this->hasOne(User::class, 'id', 'inactive_by_user_id');
    }

    public function transactions()
    {
        return $this->hasMany(SavingsTransaction::class, 'savings_id', 'id')->orderBy('submitted_on', 'asc')->orderBy('id', 'asc');
    }
}
