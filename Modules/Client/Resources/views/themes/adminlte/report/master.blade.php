@extends('core::layouts.master')
@section('title')
    {{ trans_choice('client::general.client',2) }}
@endsection
@section('styles')
@stop
@section('content')
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>{{ trans_choice('client::general.client',2) }}</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a
                                    href="{{url('dashboard')}}">{{ trans_choice('dashboard::general.dashboard',1) }}</a>
                        </li>
                        <li class="breadcrumb-item active">{{ trans_choice('client::general.client',2) }}</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="card">
           <div class="row mt-2">
                <div class="col-md-1 ml-3">
                    <div class="form-group">                        
                        <div class="btn-group">
                            <div class="dropdown">
                                <a href="#" class="btn btn-trigger btn-icon dropdown-toggle"
                                    data-toggle="dropdown">Branch
                                    <i class="fas fa-cog"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-xs">
                                    <a href="#" class="dropdown-item"><span>All</span></a>
                                    @foreach(\Modules\Branch\Entities\Branch::all() as $key)
                                    <a href="{{request()->fullUrlWithQuery(['branch_id'=>$key->id])}}"
                                    class="dropdown-item {{request('branch_id')==$key->id?'active':''}}">
                                        {{$key->name}}
                                    </a>
                                    @endforeach
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1 ml-3">
                    <div class="form-group">                        
                        <div class="btn-group">
                            <div class="dropdown">
                                <a href="#" class="btn btn-trigger btn-icon dropdown-toggle"
                                    data-toggle="dropdown">Groups
                                    <i class="fas fa-users"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-xs">
                                    <a href="#" class="dropdown-item"><span>All</span></a>
                                    @foreach(\Modules\Client\Entities\Group::all() as $key)
                                    <a href="{{request()->fullUrlWithQuery(['group_id'=>$key->id])}}"
                                    class="dropdown-item {{request('group_id')==$key->id?'active':''}}">
                                        {{$key->group_name}}
                                    </a>
                                    @endforeach
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1 ml-3">
                    <div class="form-group">                        
                        <div class="btn-group">
                            <div class="dropdown">
                                <a href="#" class="btn btn-trigger btn-icon dropdown-toggle"
                                    data-toggle="dropdown">Profesions
                                    <i class="fas fa-briefcase"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-xs">
                                    <a href="#" class="dropdown-item"><span>All</span></a>
                                    @foreach(\Modules\Client\Entities\Profession::all() as $key)
                                    <a href="{{request()->fullUrlWithQuery(['profession_id'=>$key->id])}}"
                                    class="dropdown-item {{request('profession_id')==$key->id?'active':''}}">
                                        {{$key->name}}
                                    </a>
                                    @endforeach
                                </div>
                            </div>
                        </div>
                    </div>
                </div>     
                <div class="col-md-2 ml-4 mt-2">
                    <div class="form-group">
                        <div class="btn-group"><strong><a href="{{url('report/client/master')}}" class="btn-btn-primary btn-rounded">Clear Filters</a></strong></div>
                    </div>
                </div>
                <div class="col-md-2 ml-3">
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
                                <!-- <a class="dropdown-item">Order</a> -->                                
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
                </div> 
                <div class="col-md-2 mt-1">
                    <div class="card-tools hidden-print">
                        <div class="dropdown">
                            <a href="#" class="btn btn-info btn-trigger btn-icon dropdown-toggle"
                            data-toggle="dropdown">
                                {{trans_choice('core::general.action',2)}}
                            </a>
                            <div class="dropdown-menu dropdown-menu-xs dropdown-menu-right">
                                <a href="{{request()->fullUrlWithQuery(['download'=>1,'type'=>'csv'])}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.csv_format',1)}}</a>
                                <a href="{{request()->fullUrlWithQuery(['download'=>1,'type'=>'excel'])}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.excel_format',1)}}</a>
                                <a href="request()->fullUrlWithQuery(['download'=>1,'type'=>'excel_2007'])}}')}}" class="dropdown-item">{{trans_choice('core::general.download',1)}} {{trans_choice('core::general.excel_2007_format',1)}}</a>
                            </div>
                        </div>
                    </div>
                </div>
           </div>
        </div>
        <div class="card">
            <div class="card-header">               
                
                <div class="card-tools">
                    <form class="form-inline ml-0 ml-md-3" action="{{url('client')}}">
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
            <div class="card-body table-responsive p-0">
                <table class="table  table-striped table-hover table-condensed table-sm" id="data-table">
                    <thead>
                    <tr>
                        <th>
                            <a href="{{table_order_link('group_name')}}">
                                {{ trans_choice('client::general.group',1) }}
                            </a>
                        </th>
                        <th>
                            <a href="{{table_order_link('name')}}">
                                {{ trans_choice('core::general.name',1) }}
                            </a>
                        </th>
                        <th>
                            <a href="{{table_order_link('id')}}">
                                {{ trans_choice('core::general.system',1) }} {{ trans_choice('core::general.id',1) }}
                            </a>
                        </th>
                        <th>
                            <a href="{{table_order_link('external_id')}}">
                                {{ trans_choice('core::general.external_id',1) }}
                            </a>
                        </th>
                        <th>
                            <a href="{{table_order_link('gender')}}">
                                {{ trans('core::general.gender') }}
                            </a>
                        </th>
                        <th>{{ trans('core::general.mobile') }}</th>
                        <th>
                            <a href="{{table_order_link('status')}}">
                                {{ trans_choice('core::general.status',1) }}
                            </a>
                        </th>
                        <th>
                            <a href="{{table_order_link('branch')}}">
                                {{ trans_choice('core::general.branch',1) }}
                            </a>
                        </th>
                        <th>
                            <a href="{{table_order_link('staff')}}">
                                {{ trans_choice('client::general.profession',1) }}
                            </a>
                        </th>
                        <th>{{ trans_choice('core::general.action',1) }}</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach($data as $key)
                        <tr>
                            <td>
                                <a href="{{url('/client/group/' . $key->id . '/show')}}">
                                    <span>{{$key->group_name}}</span>
                                </a>
                            </td>
                            <td>
                                <a href="{{url('client/' . $key->id . '/show')}}">
                                    <span>{{$key->name}}</span>
                                </a>
                            </td>
                            <td>
                                <span>{{$key->id}}</span>
                            </td>
                            <td>
                                <span>{{$key->external_id}}</span>
                            </td>
                            <td>
                                @if($key->gender == "male")
                                    <span>{{trans_choice('core::general.male',1)}}</span>
                                @endif
                                @if($key->gender == "female")
                                    <span>{{trans_choice('core::general.female',1)}}</span>
                                @endif
                                @if($key->gender == "other")
                                    <span>{{trans_choice('core::general.other',1)}}</span>
                                @endif
                                @if($key->gender == "unspecified")
                                    <span>{{trans_choice('core::general.unspecified',1)}}</span>
                                @endif
                            </td>
                            <td>
                                <span>{{$key->mobile}}</span>
                            </td>
                            <td>
                                @if($key->status == "pending")
                                    <span>{{trans_choice('core::general.pending',1)}}</span>
                                @endif
                                @if($key->status == "active")
                                    <span>{{trans_choice('core::general.active',1)}}</span>
                                @endif
                                @if($key->status == "inactive")
                                    <span>{{trans_choice('core::general.inactive',1)}}</span>
                                @endif
                                @if($key->status == "deceased")
                                    <span>{{trans_choice('client::general.deceased',1)}}</span>
                                @endif
                                @if($key->status == "unspecified")
                                    <span>{{trans_choice('core::general.unspecified',1)}}</span>
                                @endif
                            </td>
                            <td>
                                <a href="{{url('branch/' . $key->branch_id . '/show')}}">
                                    <span>{{$key->branch}}</span>
                                </a>
                            </td>
                            <td>
                                <a href="{{url('user/' . $key->loan_officer_id . '/show')}}">
                                    <span>{{$key->profession}}</span>
                                </a>
                            </td>
                            <td>
                                <div class="btn-group">
                                    <button href="#" class="btn btn-default dropdown-toggle"
                                            data-toggle="dropdown">
                                        <i class="fas fa-ellipsis-h"></i>
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-right">
                                        <a href="{{url('client/' . $key->id . '/show')}}" class="dropdown-item">
                                            <i class="far fa-eye"></i>
                                            <span>{{trans_choice('core::general.detail',2)}}</span>
                                        </a>
                                        @can('core.payment_types.edit')
                                            <a href="{{url('client/' . $key->id . '/edit')}}" class="dropdown-item">
                                                <i class="far fa-edit"></i>
                                                <span>{{trans_choice('core::general.edit',1)}}</span>
                                            </a>
                                        @endcan
                                        <div class="divider"></div>
                                        @can('core.payment_types.destroy')
                                            <a href="{{url('client/' . $key->id . '/destroy')}}"
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
