<?php
/**
 * Created by PhpStorm.
 * User: tj
 * Date: 7/14/19
 * Time: 2:09 PM
 */

namespace Modules\Loan\Reports;
class ReportsLinks
{
    protected $links;

    public function __construct()
    {

    }

    function get_links()
    {
        return [
            "report/loan" => trans_choice('loan::general.loan', 1) . ' ' . trans_choice('report::general.report', 2),
        ];

    }

}