@extends('core::layouts.master')
@section('title')
    {{trans_choice('user::general.register',2)}}
@endsection
@section('content')
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>{{trans_choice('user::general.register',2)}}</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a
                                    href="{{url('dashboard')}}">{{ trans_choice('dashboard::general.dashboard',1) }}</a>
                        </li>
                        <li class="breadcrumb-item"><a
                                    href="{{url('report')}}">{{ trans_choice('report::general.report',2) }}</a>
                        </li>
                        <li class="breadcrumb-item"> <a
                                    href="{{url('report/user')}}">{{trans_choice('user::general.user',1)}} {{trans_choice('report::general.report',2)}}</a></li>
                        <li class="breadcrumb-item">{{trans_choice('user::general.register',1)}} {{trans_choice('report::general.report',2)}}
                        </li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <section class="content" id="app">
        <div class="card">
            <div class="card-header with-border">
                <h3 class="card-title">
                    {{trans_choice('user::general.register_report',2)}}
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
                            <a href="{{request()->fullUrlWithQuery(['download'=>1,'type'=>'csv'])}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.csv_format',1)}}</a>
                            <a href="{{request()->fullUrlWithQuery(['download'=>1,'type'=>'excel'])}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.excel_format',1)}}</a>
                            <a href="{{request()->fullUrlWithQuery(['download'=>1,'type'=>'excel_2007'])}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.excel_2007_format',1)}}</a>
                            <a href="{{request()->fullUrlWithQuery(['download'=>1,'type'=>'pdf'])}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.pdf_format',1)}}</a>
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
                                       for="user_id">{{trans_choice('user::general.staff',1)}}</label>
                                <select class="form-control select2" name="user_id" id="user_id">
                                    <option value=""
                                            selected>{{trans_choice('core::general.all',1)}}</option>
                                    @foreach($users as $key)
                                        <option value="{{$key->id}}"
                                                @if($user_id==$key->id) selected @endif>{{$key->full_name}}</option>
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

        </div>
        <!-- /.box -->
        @if(!empty($start_date))
            <div class="box box-white">
                <div class="box-body table-responsive no-padding">


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
                            // $loans_total = $loans_total + $key->loan_transactions[0]->total_loans;
                            // $savings_total = $savings_total + $key->savings_transactions[0]->total_savings;
                            // $incomes_total = $incomes_total + $key->income[0]->total_incomes;
                            // $expenses_total = $expenses_total + $key->expenses[0]->total_expenses;
                            ?>
                            <tr>
                                <td>{{ $key->id }}</td>
                                <td>
                                    <a href="{{url('report/user/detailed_register?register_id='.$key->id.'&start_date='.$start_date.'&end_date='.$end_date.'&user_id='.$user_id)}}">{{$key->code}}</a>
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
