@extends('core::layouts.master')
@section('title')
    {{ trans_choice('expense::general.expense',2) }}
@endsection
@section('styles')
@stop
@section('content')
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>{{ trans_choice('expense::general.expense',2) }}</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a
                                    href="{{url('dashboard')}}">{{ trans_choice('dashboard::general.dashboard',1) }}</a>
                        </li>
                        <li class="breadcrumb-item active">{{ trans_choice('expense::general.expense',2) }}</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="card">
            <div class="card-header">
                    @can('expense.expenses.create')
                        <a href="{{ url('expense/create') }}" class="btn btn-info btn-sm">
                            <i class="fas fa-plus"></i> {{ trans_choice('core::general.add',1) }} {{ trans_choice('expense::general.expense',1) }}
                        </a>
                    @endcan
                <div class="btn-group">
                    <div class="dropdown">
                        <a href="#" class="btn btn-trigger btn-icon dropdown-toggle"
                           data-toggle="dropdown">
                            <i class="fas fa-wrench"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-xs">
                            <a class="dropdown-item"><span>Show</span></a>
                            <a href="{{request()->fullUrlWithQuery(['per_page'=>10])}}"
                               class="dropdown-item {{request('per_page')==10?'active':''}}">
                                10
                            </a>
                            <a href="{{request()->fullUrlWithQuery(['per_page'=>20])}}"
                               class="dropdown-item {{(request('per_page')==20||!request('per_page'))?'active':''}}">
                                20
                            </a>
                            <a href="{{request()->fullUrlWithQuery(['per_page'=>50])}}"
                               class="dropdown-item {{request('per_page')==50?'active':''}}">50</a>
                            <a class="dropdown-item">Order</a>
                            <a href="{{request()->fullUrlWithQuery(['order_by_dir'=>'asc'])}}"
                               class="dropdown-item {{(request('order_by_dir')=='asc'||!request('order_by_dir'))?'active':''}}">
                                ASC
                            </a>
                            <a href="{{request()->fullUrlWithQuery(['order_by_dir'=>'desc'])}}"
                               class="dropdown-item {{request('order_by_dir')=='desc'?'active':''}}">
                                DESC
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-tools">
                    <form class="form-inline ml-0 ml-md-3" action="{{url('expense')}}">
                        <div class="input-group input-group-sm">
                            <input type="text" name="s" class="form-control" value="{{request('s')}}"
                                   placeholder="Search">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card-body p-0">
                <table id="data-table" class="table table-striped table-hover table-sm">
                    <thead>
                    <tr>
                        <th>
                            <a href="{{table_order_link('id')}}">
                                {{ trans_choice('core::general.id',1) }}
                            </a>
                        </th>
                        <th>
                            <a href="{{table_order_link('expense_type')}}">
                                <span>{{trans_choice('expense::general.expense',1)}}</span>
                            </a>
                        </th>                        
                        <th><span>{{trans_choice('core::general.payment_method',1)}}</span></th>
                        <th><span>{{trans_choice('core::general.receipt',1)}}</span></th>
                        <th>
                            <a href="{{table_order_link('date')}}">
                                <span>{{trans_choice('core::general.date',1)}}</span>
                            </a>
                        </th>
                        <th><span>{{trans_choice('core::general.group',1)}}</span></th>
                        <th><span>{{trans_choice('core::general.branch',1)}}</span></th>
                        <th>{{trans_choice('user::general.user',1)}}</th>
                        <th>
                            <a href="{{table_order_link('amount')}}">
                                <span>{{trans_choice('expense::general.amount',1)}}</span>
                            </a>
                        </th>                        
                        <th>{{ trans_choice('core::general.action',1) }}</th>
                    </tr>
                    @php $total = 0; @endphp
                    </thead>
                    <tbody>
                    @foreach($data as $key)
                        @php $total += $key->amount @endphp
                        <tr>
                            <td>
                                <a href="{{url('expense/' . $key->id . '/show')}}">
                                    <span>{{$key->id}}</span>
                                </a>
                            </td>
                            <td>
                                <span>{{$key->expense_type}} {{$key->description}}</span>
                            </td>                            
                            <td>{{@$key->payment_method->name}}</td>
                            <td>{{$key->receipt}}</td>
                            <td>
                                <span>{{$key->date}}</span>
                            </td>
                            <td>{{@$key->group->group_name}}</td>
                            <td>{{@$key->branch->name}}</td>
                            <td>{{@$key->created_by->first_name}} {{@$key->created_by->last_name}}</td>
                            <td>
                                <span><strong>{{$key->currency->code }} {{number_format($key->amount,2)}}</strong></span>
                            </td>                            
                            <td>
                                <div class="btn-group">
                                    <button href="#" class="btn btn-default dropdown-toggle"
                                            data-toggle="dropdown">
                                        <i class="fas fa-ellipsis-h"></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <a href="{{url('expense/' . $key->id . '/show')}}"  class="dropdown-item">
                                            <i class="fas fa-eye"></i>
                                            <span>{{trans_choice('core::general.detail',2)}}</span>
                                        </a>
                                        @can('expense.expenses.edit')
                                            <a href="{{url('expense/' . $key->id . '/edit')}}"
                                               class="dropdown-item">
                                                <i class="far fa-edit"></i>
                                                <span>{{trans_choice('core::general.edit',1)}}</span>
                                            </a>
                                        @endcan
                                        <div class="dropdown-divider"></div>
                                        @can('expense.expenses.destroy')
                                            <a href="{{url('expense/' . $key->id . '/destroy')}}"
                                               class="dropdown-item confirm">
                                                <i class="fas fa-trash"></i>
                                                <span>{{trans_choice('core::general.delete',1)}}</span>
                                            </a>
                                        @endcan
                                    </div>
                                </div>
                            </td>
                        </tr>
                    @endforeach
                    <tr>
                        <td colspan="8" ></td>
                        <td><strong>Ksh {{number_format($total, 2)}}</strong></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>

            </div>
            <div class="card-footer">
                <div class="row">
                    <div class="col-md-4">
                        <div>{{ trans_choice('core::general.page',1) }} {{$data->currentPage()}} {{ trans_choice('core::general.of',1) }} {{$data->lastPage()}}</div>
                    </div>
                    <div class="col-md-4">
                        <div class="d-flex justify-content-center">
                            {{$data->links()}}
                        </div>
                    </div>
                    <div class="col-md-4">

                    </div>
                </div>

            </div>

        </div>

    </section>
@endsection
@section('scripts')
    <script>
        var app = new Vue({
            el: "#app",
            data: {
                records:{!!json_encode($data)!!},
                selectAll: false,
                selectedRecords: []
            },
            methods: {
                selectAllRecords() {
                    this.selectedRecords = [];
                    if (this.selectAll) {
                        this.records.data.forEach(item => {
                            this.selectedRecords.push(item.id);
                        });
                    }
                },
            },
        })
    </script>
@endsection
