<style>
    body{
        font-size: 9px;
    }
    .table {
        width: 100%;
        border: 1px solid #ccc;
        border-collapse: collapse;
    }

    .table th, td {
        padding: 5px;
        text-align: left;
        border: 1px solid #ccc;
    }

    .light-heading th {
        background-color: #eeeeee
    }

    .green-heading th {
        background-color: #4CAF50;
        color: white;
    }

    .text-center {
        text-align: center;
    }

    .table-striped tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .text-danger {
        color: #a94442;
    }
    .text-success {
        color: #3c763d;
    }

</style>
<h3 class="text-center">{{\Modules\Setting\Entities\Setting::where('setting_key','core.company_name')->first()->setting_value}}</h3>
<h3 class="text-center">{{trans_choice('user::general.register',2)}}</h3>
<table class="table table-bordered table-condensed table-hover">
                        <thead>
                        <tr>
                            <th colspan="6">
                                {{trans_choice('core::general.branch',1)}}:
                                @if(!empty($data->first()))
                                    {{$data->first()->full_name}}
                                @endif
                            </th>
                            <th colspan="3">{{trans_choice('core::general.start_date',1)}}: {{$start_date}}</th>
                            <th colspan="3">{{trans_choice('core::general.end_date',1)}}: {{$end_date}}</th>
                        </tr>
                        <tr style="background-color: #D1F9FF">
                            <th>{{trans_choice('core::general.id', 1)}}</th>
                            <th>{{trans_choice('user::general.register',1)}}</th>
                            <th>{{trans_choice('user::general.staff',1)}}</th>
                            <th>{{trans_choice('user::general.opened',1)}}</th>
                            <!-- <th>{{trans_choice('core::general.end_date',1)}}</th> -->
                            <th>{{trans_choice('user::general.status',1)}}</th>
                            <th>{{trans_choice('expense::general.expense',2)}}</th>
                            <th>{{trans_choice('income::general.income',1)}}</th>
                            <th>{{trans_choice('loan::general.repayment',2)}}</th>
                            <th>{{trans_choice('savings::general.savings',1)}}</th>
                            <th>{{trans_choice('user::general.approved',1)}}</th>
                            <th>{{trans_choice('user::general.closed',1)}}</th>
                            <th>{{trans_choice('core::general.note',2)}}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $loans_total = 0;
                        $savings_total = 0;
                        $incomes_total = 0;
                        $expenses_total = 0;
                        ?>
                        @foreach($data as $key)
                            <?php
                            $loans_total = $loans_total + $key->loan_transactions[0]->total_loans;
                            $savings_total = $savings_total + $key->savings_transactions[0]->total_savings;
                            $incomes_total = $incomes_total + $key->income[0]->total_incomes;
                            $expenses_total = $expenses_total + $key->expenses[0]->total_expenses;
                            ?>
                            <tr>
                                <td>{{ $key->id }}</td>
                                <td>
                                    {{$key->code}}
                                </td>
                                <td>{{ $key->user->full_name }}</td>
                                <td>{{ $key->created_at }}</td>
                                <!-- <td>{{ $key->closing_time }}</td> -->
                                <td>{{ $key->status }}</td>
                                <td>
                                    {{ number_format($key->expenses[0]->total_expenses,2) }}                                    
                                </td>
                                <td>
                                    {{ number_format($key->income[0]->total_incomes,2) }} 
                                </td>
                                <td> 
                                    {{ number_format($key->loan_transactions[0]->total_loans,2)}}
                                </td>
                                <td>
                                    {{ number_format($key->savings_transactions[0]->total_savings,2) }}
                                </td>
                                <td>{{ $key->approval_time }}</td>
                                <td>{{ $key->closing_time }}</td>
                                <td>{{ $key->notes }}</td>
                            </tr>
                        @endforeach
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="5"><b>{{trans_choice('core::general.total',1)}}</b></td>
                            <td>{{number_format($expenses_total,2)}}</td>
                            <td>{{number_format($incomes_total,2)}}</td>
                            <td>{{number_format($loans_total,2)}}</td>
                            <td>{{number_format($savings_total,2)}}</td>
                            <td colspan="4"></td>
                        </tr>
                        </tfoot>
                    </table>