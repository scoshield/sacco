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
@include('core::themes.adminlte.letterhead.index')
&nbsp;
<h3 class="text-center" style="text-transform: uppercase;">{{trans_choice('user::general.register',2)}} {{$data->first()->code}}</h3>

                    <table class="table table-bordered table-condensed table-hover">
                        <thead>
                        <tr>
                            <th colspan="6">
                                {{trans_choice('user::general.staff',1)}}:
                                @if(!empty($user_id))
                                    {{$data->first()->user->full_name}}
                                @else All
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
                            <tr>
                                <td>{{ $key->id }}</td>
                                <td>
                                    {{$key->code}}
                                </td>
                                <td>{{ $key->user->full_name }}</td>
                                <td>{{ $key->created_at }}</td>
                                <td>{{ $key->status }}</td>
                                <td>
                                    @foreach($key->expenses as $expense)        
                                        @php $expenses_total = $expenses_total + $expense->total_expenses; @endphp
                                        {{ number_format($expense->total_expenses,2) }}   
                                    @endforeach
                                </td>
                                <td>
                                    @foreach($key->income as $income)     
                                        @php $incomes_total = $incomes_total + $income->total_incomes; @endphp   
                                        {{ number_format($income->total_incomes,2) }}   
                                    @endforeach
                                    
                                </td>
                                <td> 
                                    @foreach($key->loan_transactions as $loan_transaction)  
                                        @php $loans_total = $loans_total + $loan_transaction->total_loans; @endphp      
                                        {{ number_format($loan_transaction->total_loans,2) }}   
                                    @endforeach                                    
                                </td>
                                <td>
                                    @foreach($key->savings_transactions as $saving)  
                                        @php $savings_total = $savings_total + $saving->total_savings; @endphp       
                                        {{ number_format($saving->total_savings,2) }}   
                                    @endforeach                                    
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
             