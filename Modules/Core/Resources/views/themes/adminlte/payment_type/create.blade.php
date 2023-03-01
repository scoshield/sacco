@extends('core::layouts.master')
@section('title')
    {{ trans_choice('core::general.add',1) }} {{ trans_choice('core::general.type',1) }}
@endsection
@section('content')
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>
                        {{ trans_choice('core::general.add',1) }} {{ trans_choice('core::general.type',1) }}
                        <a href="#" onclick="window.history.back()"
                           class="btn btn-outline-light bg-white d-none d-sm-inline-flex">
                            <em class="icon ni ni-arrow-left"></em><span>{{ trans_choice('core::general.back',1) }}</span>
                        </a>
                    </h1>

                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a
                                    href="{{url('dashboard')}}">{{ trans_choice('dashboard::general.dashboard',1) }}</a>
                        </li>
                        <li class="breadcrumb-item"><a
                                    href="{{url('payment_type')}}">{{ trans_choice('core::general.payment',1) }} {{ trans_choice('core::general.type',2) }}</a>
                        </li>
                        <li class="breadcrumb-item active">{{ trans_choice('core::general.add',1) }} {{ trans_choice('core::general.type',1) }}</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <section class="content" id="app">
        <form method="post" action="{{ url('payment_type/store') }}">
            {{csrf_field()}}
            <div class="card card-bordered card-preview">
                <div class="card-body">
                    <div class="row gy-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="name"
                                       class="control-label">{{trans_choice('core::general.name',1)}}</label>
                                <input type="text" name="name" v-model="name"
                                       id="name"
                                       class="form-control @error('name') is-invalid @enderror" required>
                                @error('name')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="description"
                                       class="control-label">{{trans_choice('core::general.description',1)}}</label>
                                <textarea type="text" name="description" v-model="description"
                                          id="description"
                                          class="form-control @error('description') is-invalid @enderror">
                                </textarea>
                                @error('description')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="position"
                                       class="control-label">{{trans_choice('core::general.position',1)}}</label>
                                <input type="text" name="position" id="position" v-model="position"
                                       class="form-control @error('position') is-invalid @enderror">
                                @error('position')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="gender" class="control-label">{{trans('user::general.control_account')}}</label>
                                <select class="form-control @error('asset_control_account') is-invalid @enderror" name="asset_control_account"
                                        id="asset_control_account" v-model="asset_control_account" required>
                                    <option value=""></option>
                                    @foreach($accounts as $key)
                                        <option value="{{$key->id}}">{{$key->name}}</option>
                                    @endforeach
                                </select>
                                @error('gender')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="is_cash"
                                       class="control-label">{{trans_choice('core::general.is_cash',1)}}</label>
                                <select class="form-control @error('is_cash') is-invalid @enderror" name="is_cash"
                                        id="is_cash" v-model="is_cash">
                                    <option value="0">{{trans_choice('core::general.no',1)}}</option>
                                    <option value="1">{{trans_choice('core::general.yes',1)}}</option>
                                </select>
                                @error('is_cash')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="active"
                                       class="control-label">{{trans_choice('core::general.active',1)}}</label>
                                <select class="form-control @error('active') is-invalid @enderror" name="active"
                                        id="active" v-model="active">
                                    <option value="0">{{trans_choice('core::general.no',1)}}</option>
                                    <option value="1">{{trans_choice('core::general.yes',1)}}</option>
                                </select>
                                @error('active')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>

                    </div>
                </div>
                <div class="card-footer border-top ">
                    <button type="submit"
                            class="btn btn-primary  float-right">{{trans_choice('core::general.save',1)}}</button>
                </div>
            </div><!-- .card-preview -->
        </form>
    </section>
@endsection
@section('scripts')
    <script>
        var app = new Vue({
            el: "#app",
            data: {
                name: "{{old('name')}}",
                is_cash: "{{old('is_cash',0)}}",
                active: "{{old('active',1)}}",
                description: "{{old('description')}}",
                position: "{{old('position')}}",
                asset_control_account: "{{old('asset_control_account')}}",
            }
        })
    </script>
@endsection