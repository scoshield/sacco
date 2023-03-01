<?php


namespace Modules\Loan\Providers;

use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * @var array
     */
    protected $listen = [
        \Modules\Loan\Events\LoanStatusChanged::class => [
            \Modules\Loan\Listeners\LoanStatusChangedCampaigns::class,
        ],
        \Modules\Loan\Events\TransactionUpdated::class => [
            \Modules\Loan\Listeners\UpdateTransactions::class,
        ],
    ];

    /**
     * Register any events for your application.
     *
     * @return void
     */
    public function boot()
    {
        parent::boot();
        //
    }

    public function shouldDiscoverEvents()
    {
        return true;
    }
}