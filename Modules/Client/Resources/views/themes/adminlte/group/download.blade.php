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
<h3 class="text-center" style="text-transform: uppercase;">{{trans_choice('core::general.group',2)}} {{$group->group_name}}</h3>
            <table class="table  table-striped table-hover table-condensed table-sm" id="data-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Client</th>
                        <th>Savings</th>
                        <th>Total</th>
                        <th>Loan</th>
                        <th>Total</th>
                        <th>Savings/Loan Ratio</th>
                        <th>Loan Profile</th>
                        <th>Repayment Profile</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($group->clients as $client)
                    <tr>@php $total_savings = 0; $total_loans = 0; $profile = 0; $repayment = 0; @endphp
                        <td></td>
                        <td>{{$client->first_name}} {{$client->middle_name}} {{$client->last_name}}</td>
                        <td>
                            @foreach($client->savings as $saving)
                                {{$saving->savings_product->short_name}} : {{number_format($saving->balance_derived, 2)}} @php $total_savings = $total_savings + $saving->balance_derived @endphp<br/>
                            @endforeach
                        </td>
                        <td>{{number_format($total_savings, 2)}}</td>
                        <td>
                            @foreach($client->loans as $loan)
                                {{$loan->loan_product->short_name}}: @php $total_due = 0; @endphp @foreach($loan->repayment_schedules as $rs) @php $total_due = $total_due + $rs->total_due; $total_loans = $total_loans + $rs->total_due; $repayment = $repayment + $rs->principal_repaid_derived; @endphp @endforeach {{number_format($total_due, 2)}} <br/>
                            @endforeach
                        </td>
                        <td>{{number_format($total_loans, 2)}}</td>
                        <td>
                            @if($total_loans != 0 )
                                {{round(($total_savings / $total_loans) * 100, 2)}}%
                            @endif
                        </td>
                        <td>
                            @foreach($client->loans as $ln)
                                @php $profile = $profile + $ln->principal; @endphp
                            @endforeach
                            {{number_format($profile, 2)}}
                        </td>
                        <td>                            
                            {{number_format($repayment, 2)}}
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>

       