@extends('core::layouts.master')
@section('title')
    {{trans_choice('accounting::general.journal_entries',2)}}
@endsection
@section('content')
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>{{trans_choice('accounting::general.journal_entries',2)}}</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a
                                    href="{{url('dashboard')}}">{{ trans_choice('dashboard::general.dashboard',1) }}</a>
                        </li>
                        <li class="breadcrumb-item"><a
                                    href="{{url('report')}}">{{ trans_choice('report::general.report',2) }}</a>
                        </li>
                        <li class="breadcrumb-item"><a
                                    href="{{url('report/accounting')}}">{{trans_choice('accounting::general.accounting',1)}} {{trans_choice('report::general.report',2)}}</a>
                        </li>
                        <li class="breadcrumb-item active">{{trans_choice('accounting::general.journal_entries',1)}}</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <section class="content" id="app">
        <div class="card">
            <div class="card-header with-border">
                <h3 class="card-title">
                    {{trans_choice('accounting::general.journal_entries',1)}}
                    @if(!empty($start_date))
                        as on: {{$end_date}}</b>
                    @endif
                </h3>

                <div class="card-tools hidden-print">
                    <div class="dropdown">
                        <a href="#" class="btn btn-info btn-trigger btn-icon dropdown-toggle"
                           data-toggle="dropdown">
                            {{trans_choice('core::general.action',2)}}
                        </a>
                        <div class="dropdown-menu dropdown-menu-xs dropdown-menu-right">
                            <a href="{{request()->fullUrlWithQuery(['download'=>1, 'type'=>'csv'])}}"
                               class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.csv_format',1)}}</a>
                            <a href="{{request()->fullUrlWithQuery(['download'=>1, 'type'=>'excel'])}}"
                               class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.excel_format',1)}}</a>
                            <a href="{{request()->fullUrlWithQuery(['download'=>1, 'type'=>'excel_2007'])}}"
                               class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.excel_2007_format',1)}}</a>
                            <a href="{{request()->fullUrlWithQuery(['download'=>1, 'type'=>'pdf'])}}"
                               class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.pdf_format',1)}}</a>
                        </div>
                    </div>
                </div>
            </div>
                       <!-- /.box-body -->

        </div>
        <!-- /.box -->
        @if(!empty($end_date))
            <div class="card">
                <div class="card-body table-responsive p-0">
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
                            <td colspan="4" class="text-center"><h4>DETAILS</h4>
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
                </div>
            </div>
        @endif
    </section>
@endsection
@section('scripts')
    <script>
        var app = new Vue({
            el: "#app",
            data: {},
            methods: {},
        })
    </script>
@endsection
