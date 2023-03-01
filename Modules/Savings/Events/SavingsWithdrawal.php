<?php

namespace Modules\Savings\Events;

use Illuminate\Queue\SerializesModels;
use Modules\Loan\Entities\Loan;

class SavingsWithdrawal
{
    use SerializesModels;
    public $loan;
    public $chart_id;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct(Loan $loan, $chart_id)
    {
        $this->loan = $loan;
        $this->chart_id = $chart_id;
    }

    /**
     * Get the channels the event should be broadcast on.
     *
     * @return array
     */
    public function broadcastOn()
    {
        return [];
    }
}
