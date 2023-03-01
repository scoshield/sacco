<style>
    body {
        font-size: 9px;
    }

    .table {
        width: 100%;
        /* border: 1px solid #ccc; */
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
<h3 class="text-center" style="text-transform: uppercase;"> {{trans_choice('loan::general.loan',1)}} Statement</h3>
<h3 class="text-center" style="text-transform: uppercase;"> {{$loan->client->first_name}} {{$loan->client->middle_name}} {{$loan->client->last_name}} | {{$loan->group->group_name}}</h3>
<table class="table table-striped table-hover" id="loan_transactions_table">
    <thead>
    <tr>
        <th>{{trans_choice('core::general.date',1)}}</th>
        <th>{{trans_choice('core::general.submitted_on',1)}}</th>
        <th>{{trans_choice('loan::general.transaction',1)}} {{trans_choice('core::general.type',1)}}</th>
        <th>{{trans_choice('loan::general.transaction',1)}} {{trans_choice('core::general.id',1)}}</th>
        <th>{{trans_choice('accounting::general.debit',1)}}</th>
        <th>{{trans_choice('accounting::general.credit',1)}}</th>
        <th>{{trans_choice('loan::general.balance',1)}}</th>
    </tr>
    </thead>
    <tbody>
    <?php
    $balance = $loan->principal;
    ?>
    @foreach($loan->transactions as $key)
        <?php
        if ($key->loan_transaction_type_id == 10 || $key->loan_transaction_type_id == 11) {
            $balance = $balance + $key->amount;
        }
        if ($key->loan_transaction_type_id == 2 || $key->loan_transaction_type_id == 4 || $key->loan_transaction_type_id == 8 || $key->loan_transaction_type_id == 9 || $key->loan_transaction_type_id == 6) {
            $balance = $balance - $key->amount;
        }
        ?>
        <tr>
            <td>{{$key->created_on}}</td>
            <td>{{$key->submitted_on}}</td>
            <td>
                @if($key->loan_transaction_type_id == 1)
                    {{trans_choice('loan::general.disbursement',1)}}
                @endif
                @if($key->loan_transaction_type_id == 2)
                    {{trans_choice('loan::general.repayment',1)}}
                @endif
                @if($key->loan_transaction_type_id == 3)
                    {{trans_choice('loan::general.contra',1)}}
                @endif
                @if($key->loan_transaction_type_id == 4)
                    {{trans_choice('loan::general.waive',1)}} {{trans_choice('loan::general.interest',1)}}
                @endif
                @if($key->loan_transaction_type_id == 5)
                    {{trans_choice('loan::general.repayment',1)}} {{trans_choice('core::general.at',1)}} {{trans_choice('loan::general.disbursement',1)}}
                @endif
                @if($key->loan_transaction_type_id == 6)
                    {{trans_choice('loan::general.write_off',1)}}
                @endif
                @if($key->loan_transaction_type_id == 7)
                    {{trans_choice('loan::general.marked_for_rescheduling',1)}}
                @endif
                @if($key->loan_transaction_type_id == 8)
                    {{trans_choice('loan::general.recovery',1)}} {{trans_choice('loan::general.repayment',1)}}
                @endif
                @if($key->loan_transaction_type_id == 9)
                    {{trans_choice('loan::general.waive',1)}} {{trans_choice('loan::general.charge',2)}}
                @endif
                @if($key->loan_transaction_type_id == 10)
                    {{trans_choice('loan::general.fee',1)}} {{trans_choice('loan::general.applied',1)}}
                @endif
                @if($key->loan_transaction_type_id == 11)
                    {{trans_choice('loan::general.interest',1)}} {{trans_choice('loan::general.applied',1)}}
                @endif
            </td>
            <td>{{$key->id}}</td>
            <td>{{number_format($key->debit,$loan->decimals)}}</td>
            <td>{{number_format($key->credit,$loan->decimals)}}</td>
            <td>{{number_format($balance,$loan->decimals)}}</td>
        </tr>
    @endforeach
    </tbody>
</table>