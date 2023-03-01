<style>
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
<h3 class="text-center" style="text-transform: uppercase;">{{trans_choice('accounting::general.journal_entries',1)}}</h3>
<table class="table table-bordered table-condensed table-hover table-striped">
    <thead>
    <tr>
        <th colspan="2">
            {{trans_choice('core::general.branch',1)}}:
            @if(!empty($branch_id))
                {{$data->first()->branch}}
            @else
                All
            @endif
        </th>

        <th>{{trans_choice('accounting::general.as_on',1)}}: {{$end_date}}</th>
    </tr>
    <tr class="bg-success">
        <th>{{trans_choice('accounting::general.gl_code',1)}}</th>
        <th>{{trans_choice('core::general.account',1)}}</th>
        <th>{{trans_choice('accounting::general.debit',1)}}</th>
        <th>{{trans_choice('accounting::general.credit',1)}}</th>
    </tr>
    </thead>
    <tbody>
    <?php
    //group the results
    $assets = [];
    $liabilities = [];
    $equities = [];
    $total_debit = 0;
    $total_credit = 0;
    $total_equities = 0;

    ?>
    <tr>
        <td colspan="3" class="text-center"><h4>DETAILS</h4>
        </td>
    </tr>
    @foreach($data as $key)
    <?php $total_credit = $total_credit + $key->credit; ?>
    <?php $total_debit = $total_debit + $key->debit; ?>
        <tr>
            <td>{{ $key->gl_code }}</td>
            <td>
                <span style="text-transform: capitalize">{{str_replace('_', ' ', $key->transaction_type)}}</span><span> {{$key->transaction_number}}</span>
            </td>
            <td>
                {{ number_format($key->debit, 2) }}
            </td>
            <td>
                {{ number_format($key->credit, 2) }}
            </td>
        </tr>
    @endforeach
    <tr>
        <td colspan="2">
            <h4>{{trans_choice('core::general.total',1)}}</h4>
        </td>
        <td><h4>{{ number_format($total_debit,2) }}</h4></td>
        <td><h4>{{ number_format($total_credit,2) }}</h4></td>
    </tr>
    </tbody>
</table>

              