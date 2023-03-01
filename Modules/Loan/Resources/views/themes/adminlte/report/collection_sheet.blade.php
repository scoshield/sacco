@extends('core::layouts.master')
@section('title')
    {{trans_choice('loan::general.collection_sheet',1)}}
@endsection
@section('content')
    <section class="content-header">
        <style>
            th,td {
                height: 30px !important;
                /* vertical-align: middle !important; */
                }

                table{
                    margin-bottom: 0px !important;
                }
                .bamboo tr:nth-child(1) {
                    border-bottom: 1px solid #000;
                }

                .table-sm td, .table-sm th {
                    padding: 0px;
                }
        </style>
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>{{trans_choice('loan::general.collection_sheet',1)}}</h1>
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
                                    href="{{url('report/loan')}}">{{trans_choice('loan::general.loan',1)}} {{trans_choice('report::general.report',2)}}</a>
                        </li>
                        <li class="breadcrumb-item active">{{trans_choice('loan::general.collection_sheet',1)}}</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <section class="content" id="app">
        <div class="card">
            <div class="card-header with-border">
                <h3 class="card-title">
                    {{trans_choice('loan::general.collection_sheet',1)}}
                    @if(!empty($start_date))
                        for period: <b>{{$start_date}} to {{$end_date}}</b>
                    @endif
                </h3>
                <div class="card-tools hidden-print">
                    <div class="dropdown">
                        <a href="#" class="btn btn-info btn-trigger btn-icon dropdown-toggle"
                           data-toggle="dropdown">
                            {{trans_choice('core::general.action',2)}}
                        </a>
                        <div class="dropdown-menu dropdown-menu-xs dropdown-menu-right">
                            <a href="{{url('report/loan/collection_sheet?download=1&type=csv&start_date='.$start_date.'&end_date='.$end_date.'&branch_id='.$branch_id.'&loan_officer_id='.$loan_officer_id.'&loan_product_id='.$loan_product_id)}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.csv_format',1)}}</a>
                            <a href="{{url('report/loan/collection_sheet?download=1&type=excel&start_date='.$start_date.'&end_date='.$end_date.'&branch_id='.$branch_id.'&loan_officer_id='.$loan_officer_id.'&loan_product_id='.$loan_product_id)}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.excel_format',1)}}</a>
                            <a href="{{url('report/loan/collection_sheet?download=1&type=excel_2007&start_date='.$start_date.'&end_date='.$end_date.'&branch_id='.$branch_id.'&loan_officer_id='.$loan_officer_id.'&loan_product_id='.$loan_product_id)}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.excel_2007_format',1)}}</a>
                            <a href="{{url('report/loan/collection_sheet?download=1&type=pdf&start_date='.$start_date.'&end_date='.$end_date.'&group_id='.$group_id.'&loan_product_id='.$loan_product_id)}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.pdf_format',1)}}</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <form method="get" action="{{Request::url()}}" class="">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label"
                                       for="group_id">{{trans_choice('core::general.group',1)}}</label>
                                <select class="form-control select2" name="group_id" id="group_id">
                                    <option value="" disabled
                                            selected>{{trans_choice('core::general.select',1)}}</option>
                                    @foreach($groups as $key)   
                                        <option value="{{$key->id}}"
                                                @if($group_id==$key->id) selected @endif>{{$key->group_name}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label"
                                       for="start_date">{{trans_choice('core::general.start_date',1)}}</label>
                                <flat-pickr value="{{$start_date}}"
                                            class="form-control  @error('start_date') is-invalid @enderror"
                                            name="start_date" id="start_date" required>
                                </flat-pickr>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label"
                                       for="end_date">{{trans_choice('core::general.end_date',1)}}</label>
                                <flat-pickr value="{{$end_date}}"
                                            class="form-control  @error('end_date') is-invalid @enderror"
                                            name="end_date" id="end_date" required>
                                </flat-pickr>
                            </div>
                        </div>
                        <!-- <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label"
                                       for="loan_officer_id">{{trans_choice('loan::general.loan',1)}} {{trans_choice('loan::general.officer',1)}}</label>
                                <select class="form-control select2" name="loan_officer_id" id="loan_officer_id">
                                    <option value="" disabled
                                            selected>{{trans_choice('core::general.select',1)}}</option>
                                    @foreach($users as $key)
                                        <option value="{{$key->id}}"
                                                @if($loan_officer_id==$key->id) selected @endif>{{$key->first_name}} {{$key->last_name}}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div> -->
                        <!-- <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label"
                                       for="loan_product_id">{{trans_choice('loan::general.loan',1)}} {{trans_choice('loan::general.product',1)}}</label>
                                <select class="form-control select2" name="loan_product_id" id="loan_product_id">
                                    <option value="" disabled
                                            selected>{{trans_choice('core::general.select',1)}}</option>
                                    @foreach($loan_products as $key)
                                        <option value="{{$key->id}}"
                                                @if($loan_product_id==$key->id) selected @endif>{{$key->name}} </option>
                                    @endforeach
                                </select>
                            </div>
                        </div> -->
                    </div>
                    <div class="row">
                        <div class="col-md-2">
                        <span class="input-group-btn">
                          <button type="submit" class="btn bg-olive btn-flat">{{trans_choice('core::general.filter',1)}}
                          </button>
                        </span>
                            <span class="input-group-btn">
                          <a href="{{Request::url()}}"
                             class="btn bg-purple  btn-flat pull-right">{{trans_choice('general.reset',1)}}!</a>
                        </span>
                        </div>
                    </div>
                </form>

            </div>
            <!-- /.box-body -->
            <table>
        </div>
        <!-- /.box -->
        @if(!empty($start_date))
            <div class="card">
                <div class="card-body table-responsive p-0">
                    <table class="table table-sm">
                    <colgroup>
                        <col>
                        <col style="border: 1px solid #000">
                        <col style="background-color:yellow">
                    </colgroup>
                        <thead>
                            <tr>
                                <th colspan="">
                                    @if(!empty($data->first()) && !empty($branch_id))
                                    {{trans_choice('core::general.branch',1)}}:
                                    
                                    {{$data->first()->branch}}
                                    @endif
                                </th>
                            <th colspan="3">{{trans_choice('core::general.start_date',1)}}: {{$start_date}}</th>
                            <th colspan="2">{{trans_choice('core::general.end_date',1)}}: {{$end_date}}</th>
                            <!-- <th></th> -->
                        </tr>
                        <tr style="background-color: #D1F9FF">
                            <th style="width: 10%; border-left:">{{trans_choice('client::general.client',1)}}</th>
                            <th style="width: 6%; border-left:">Cash</th>
                            <th style="width: 6%; border-left:">Non Cash</th>
                            <th style="width: 50%; text-align: center; border-left: 1px solid #000;">
                            <table class="table table-sm" style="width: 100%; border: 0px">
                                <tr style="border-bottom: 1px solid #000">
                                    <td colspan="6">{{trans_choice('loan::general.loan',1)}}</td>
                                </tr>
                                <tr style="text-align: left">
                                    <td style="width: 14%; border-left:">#</td>
                                    <td style="width: 14%; border-left: 1px solid #000;">B/F</td>
                                    <td style="width: 14%; border-left: 1px solid #000;">Principal</td>
                                    <td style="width: 14%; border-left: 1px solid #000;">Interest</td>
                                    <td style="width: 14%; border-left: 1px solid #000;">Repaid</td>
                                    <!-- <td style="width: 14%; border-left: 1px solid #e3e3e3;">T. Due</td> -->
                                    <!-- <td style="width: 14%; border-left: 1px solid #e3e3e3;"></td> -->
                                </tr>
                            </table>
                        </th>
                        <th style="width: 20%; text-align: center; border-left: 1px solid #000; border-right: 1px solid #000;">{{ trans_choice('savings::general.savings',1) }}</th>
                        <th style="width: 8%; border-left: 1px solid #000;"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $total_due = 0;
                        $total_principal = 0;
                        $total_carried_down = 0;
                        $total_interest = 0;
                        $total_principal_repaid = 0;
                        $total_interest_repaid = 0;
                        $total_expected_amount = 0;
                        $total_savings = 0;
                        ?>
                        @foreach($clients as $key)
                            <?php
                            // $total_due = $total_due + $key->total_due;
                            // $total_expected_amount = $total_expected_amount + $key->expected_amount;
                            ?>
                            <tr style="border: 2px solid #000 !important">
                                <td style="vertical-align: middle !important">{{ $key->name }}</td>
                                <td style="border-left: 1px solid #000"></td>
                                <td style="border-left: 1px solid #000"></td>
                                <td style="border-left: 1px solid #000">
                                    <table class="table table-sm bamboo">
                                        @foreach($key->loans as $loan)
                                            @if(count($loan->repayment_schedules) != 0 )
                                                @if($loan->status == 'active')
                                                    <tr>
                                                        <td style="width: 14%">{{$loan->loan_product->name}}</td>
                                                        <!-- <td colspan="5"> -->
                                                            <!-- <table class="table table-sm"> -->
                                                            @foreach($loan->repayment_schedules as $schedule)
                                                                <?php $total_due = $total_due + $schedule->total_due; ?>
                                                                <?php
                                                                    $total_principal = $total_principal + $schedule->principal;
                                                                    $total_carried_down = $total_carried_down + $schedule->principal_balance;
                                                                    $total_interest = $total_interest + $schedule->interest;
                                                                    $total_principal_repaid = $total_principal_repaid + $schedule->principal_repaid_derived;
                                                                    $total_interest_repaid = $total_interest_repaid + $schedule->interest_repaid_derived;
                                                                    $total_expected_amount = 0;
                                                                ?>
                                                            <!-- <tr> -->
                                                                <td style="width: 14%; border-left: 1px solid #000">{{number_format($schedule->principal_balance, 2)}}</td>
                                                                <td style="width: 14%; border-left: 1px solid #000">{{number_format($schedule->principal, 2)}}</td>
                                                                <td style="width: 14%; border-left: 1px solid #000">{{number_format($schedule->interest, 2)}}</td>
                                                                <td style="width: 14%; border-left: 1px solid #000"></td>
                                                                <!-- <td style="width: 14%; border-left: 1px solid #e3e3e3">{{number_format($schedule->total_due, 2)}}</td> -->
                                                                <!-- <td style="width: 14%; border-left: 1px solid #e3e3e3"></td> -->
                                                            <!-- </tr> -->
                                                            @endforeach
                                                        <!-- </table> -->
                                                    <!-- </td> -->
                                                    </tr>
                                                @endif
                                            @endif
                                        @endforeach
                                    </table>
                                </td>
                                <td style="border-left: 1px solid #000;">
                                    <table class="table table-sm table-borderless bamboo">
                                        @foreach($key->savings as $saving)
                                        <?php $total_savings = $total_savings + $saving->balance_derived ?>
                                        <tr style=":nth-child(1){border: 1px solid #000;}">
                                            <td style="width: 33%; border-left: 0px solid #000;">{{ $saving->savings_product->short_name }}</td>
                                            <td style="width: 33%; border-left: 1px solid #000">{{ number_format($saving->balance_derived, 2) }}</td>
                                            <td style="width: 33%; border-left: 1px solid #000"></td>
                                        </tr>
                                        @endforeach
                                    </table>
                                </td>
                                <td style="border-left: 1px solid #000;"></td>
                            </tr>
                        @endforeach
                        </tbody>
                        <tfoot>
                        <tr>
                            <td><b>{{trans_choice('core::general.total',1)}}</b></td>
                            <td></td>
                            <td></td>
                            <td> 
                                <table class="table table-sm">
                                <tr style="text-align: left">
                                    <td style="width: 14%; border-left:">#</td>
                                    <td style="width: 14%; border-left: 1px solid #000;">{{number_format($total_carried_down,2)}}</td>
                                    <td style="width: 14%; border-left: 1px solid #000;">{{number_format($total_principal,2)}}</td>
                                    <td style="width: 14%; border-left: 1px solid #000;">{{number_format($total_interest,2)}}</td>
                                    <td style="width: 14%; border-left: 1px solid #000;"></td>
                                    <!-- <td style="width: 14%; border-left: 1px solid #e3e3e3;">{{number_format($total_principal_repaid + $total_interest_repaid,2)}}</td> -->
                                    <!-- <td style="width: 14%; border-left: 1px solid #e3e3e3;">{{number_format($total_due,2)}}</td> -->
                                    <!-- <td style="width: 14%; border-left: 1px solid #e3e3e3"></td> -->
                                </tr>
                                </table>
                            </td>
                            <!-- <td style="width: 14%; border-left: 1px solid #e3e3e3"></td> -->
                            <td style="border-left: 1px solid #e3e3e3">
                            <table class="table table-sm">
                                <tr>
                                    <td style="width: 33%; border-left: 1px solid #000;"></td>
                                    <td style="width: 33%; border-left: 1px solid #000;">{{number_format($total_savings , 2)}}</td>
                                    <td style="width: 33%; border-left: 1px solid #000;"></td>
                                </tr>
                            </table>
                            </td>
                            <td></td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        @endif
        <!-- /.box -->
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
