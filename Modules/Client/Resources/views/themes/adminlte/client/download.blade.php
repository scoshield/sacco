<style>
    body {
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
<h3 class="text-center"> {{trans_choice('client::general.client',2)}}</h3>
<table class="table table-bordered table-striped table-hover">
    <thead>
    
    <tr class="green-heading">
        <th>{{trans_choice('client::general.group',1)}}</th>
        <th>{{trans_choice('core::general.name',1)}}</th>
        <th>{{trans_choice('core::general.system',1)}}#</th>
        <th>{{trans_choice('core::general.external_id',1)}} {{trans_choice('loan::general.officer',1)}}</th>
        <th>{{trans_choice('core::general.gender',1)}}</th>
        <th>{{ trans_choice('core::general.mobile',1) }}</th>
        <th>{{ trans_choice('core::general.branch',2) }}</th>
        <th>{{ trans_choice('client::general.profession',1) }}</th>
        <th>{{trans_choice('core::general.status',2)}}</th>
        <!-- <th>{{ trans_choice('core::general.date',1) }}</th> -->
        <!-- <th>{{ trans_choice('core::general.payment',1) }} {{ trans_choice('core::general.type',1) }}</th> -->
    </tr>
    </thead>
    <tbody>
    @foreach($data as $key) 
        <tr>
            <td>{{ $key->group_name }}</td>
            <td>
                {{$key->name}}
            </td>
            <td>{{ $key->id }}</td>
            <td>{{ $key->external_id }}</td>
            <td>{{ $key->gender }}</td>
            <td>{{ $key->mobile }}</td>
            <td>{{ $key->branch }}</td>
            <td>{{ $key->profession }}</td>
            <td>{{ $key->status }}</td>
            <!-- <td>{{ $key->submitte_on }}</td> -->
            <!-- <td>{{ $key->payment_type }}</td> -->
        </tr>
    @endforeach
    </tbody>
    <tfoot>
    
    </tfoot>
</table>