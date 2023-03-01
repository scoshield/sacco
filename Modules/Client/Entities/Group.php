<?php

namespace Modules\Client\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\User\Entities\User;
use Modules\Loan\Entities\Loan;
use Modules\Savings\Entities\Savings;
use Modules\Events\Entities\Event;
use Modules\Loan\Entities\LoanRepaymentSchedule;
use Modules\Expense\Entities\Expense;
use Modules\Income\Entities\Income;
use Modules\Branch\Entities\Branch;
use Modules\Core\Entities\PaymentDetail;

class Group extends Model
{
    protected $table='client_groups';
    public $timestamps=false;
    protected $fillable = [];

    // public function users()
    // {
    //     return $this->hasMany(User::class, 'group_id', 'id');
    // }

    public function loans()
    {
        return $this->hasMany(Loan::class, 'group_id', 'id')->where('disbursed_on_date', '!=', null);
    }

    public function savings()
    {
        return $this->hasMany(Savings::class, 'group_id', 'id');
    }

    public function events()
    {
        return $this->hasMany(Event::class);
    }

    public function clients()
    {
        return $this->hasMany(Client::class)->where('status', 'active');
    }

    public function schedules()
    {
        return $this->hasManyThrough(LoanRepaymentSchedule::class, Loan::class);
    }

    public function expenses()
    {
        return $this->hasMany(Expense::class);
    }

    public function income()
    {
        return $this->hasMany(Income::class);
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }

    public function payment_details()
    {
        return $this->hasMany(PaymentDetail::class, 'group_id', 'id');
    }
}
