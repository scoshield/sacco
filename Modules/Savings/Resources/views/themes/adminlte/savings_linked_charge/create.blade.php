@extends('core::layouts.master')
@section('title')
    {{ trans_choice('core::general.add',1) }} {{ trans_choice('savings::general.charge',1) }}
@endsection
@section('content')
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>
                        {{ trans_choice('core::general.add',1) }} {{ trans_choice('savings::general.charge',1) }}
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
                                    href="{{url('savings/'.$savings->id.'/show')}}">{{ trans_choice('savings::general.savings',2) }}</a>
                        </li>
                        <li class="breadcrumb-item active">{{ trans_choice('core::general.add',1) }} {{ trans_choice('savings::general.charge',1) }}</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <section class="content" id="app">
        <form method="post" action="{{ url('savings/'.$savings->id.'/charge/store') }}">
            {{csrf_field()}}
            <div class="card card-bordered card-preview">
                <div class="card-body">
                    <div class="form-group">
                        <label for="savings_charge_id"
                               class="control-label">{{trans_choice('savings::general.charge',1)}}</label>
                        <select class="form-control  @error('savings_charge_id') is-invalid @enderror"
                                name="savings_charge_id" id="savings_charge_id"
                                v-model="savings_charge_id" v-on:click="change_charge" required>
                            <option value=""></option>
                            <option v-for="(charge,index) in charges" v-bind:value="index">
                                @{{ charge.name }}
                            </option>
                        </select>
                        @error('savings_charge_id')
                        <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                        @enderror
                    </div>
                    <div class="form-group">
                        <label for="amount" class="control-label">{{trans('core::general.amount')}}</label>
                        <input type="text" name="amount" value="{{ old('amount') }}" id="amount" v-model="amount"
                               class="form-control  @error('amount') is-invalid @enderror numeric" required>
                        @error('amount')
                        <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                        @enderror
                    </div>
                    <div class="form-group">
                        <label for="date" class="control-label">{{trans('core::general.date')}}</label>
                        <flat-pickr
                                v-model="date"
                                class="form-control  @error('date') is-invalid @enderror"
                                name="date" id="date" required>
                        </flat-pickr>
                        @error('date')
                        <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                        @enderror
                    </div>
                </div>
                <div class="card-footer border-top ">
                    <button type="submit"
                            class="btn btn-primary  float-right">{{trans_choice('core::general.save',1)}}</button>
                </div>
            </div>
        </form>
    </section>
@endsection
@section('scripts')
    <script>
        var app = new Vue({
            el: '#app',
            data: {
                savings_charge_id: "{{ old('savings_charge_id') }}",
                amount: "{{ old('amount') }}",
                date: "{{ old('date',date("Y-m-d")) }}",
                charges: charges,
            },
            methods: {}
        })
    </script>
@endsection