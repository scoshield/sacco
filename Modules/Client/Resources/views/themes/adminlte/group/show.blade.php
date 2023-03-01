@extends('core::layouts.master')
@section('title')
    {{ $group->group_name }}
@endsection
@section('content')
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>{{ trans_choice('core::general.group',1) }} {{ trans_choice('client::general.client',2) }}: {{ $group->group_name }}</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a
                                href="{{url('dashboard')}}">{{ trans_choice('dashboard::general.dashboard',1) }}</a>
                    </li>
                    <li class="breadcrumb-item active">{{ trans_choice('core::general.group',2) }}</li>
                </ol>
            </div>
        </div>
    </div><!-- /.container-fluid -->
</section>
<section class="content">
    <div class="card box-primary">
        <div class="card-header with-border">
            <h6 class="box-title">{{ $group->group_name }}</h6>

            <div class="heading-elements">
                <a href="{{request()->fullUrlWithQuery(['download'=>1,'type'=>'pdf'])}}" class="btn btn-primary btn-sm">Download</a>
            </div>
        </div>

        <div class="card-body">
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
                        <td>{{$client->id}}</td>
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

        </div>

    </div>
</secction>
@endsection
@section('scripts')

@endsection