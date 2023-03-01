@extends('core::layouts.master')
@section('title')
    {{ trans_choice('core::general.add',1) }} {{ trans_choice('expense::general.expense',1) }}
@endsection
@section('content')
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>
                        {{ trans_choice('core::general.add',1) }} {{ trans_choice('expense::general.expense',1) }}
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
                                    href="{{url('expense')}}">{{ trans_choice('expense::general.expense',2) }}</a>
                        </li>
                        <li class="breadcrumb-item active">{{ trans_choice('core::general.add',1) }} {{ trans_choice('expense::general.expense',1) }}</li>
                    </ol>
                </div>
                @if(@$status)
                <div class="col-md-12">
                    <div class="aler-alert-info">
                        {{@$status}}
                    </div>
                </div>
                @endif
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <section class="content" id="app">
        <form method="post" action="{{ url('expense/store') }}">
            {{csrf_field()}}
            <div class="row">
                <div class="col-sm-12 col-lg-6 col-md-6">
                    <div class="card card-bordered card-preview">
                    <div class="card-body">
                        <div class="form-group">
                            <label for="branch_id"
                                class="control-label">{{trans_choice('branch::general.branch',1)}}
                            </label>
                            <v-select label="name" :options="branches"
                                    :reduce="branch => branch.id"
                                    v-model="branch_id">
                                <template #search="{attributes, events}">
                                    <input
                                            autocomplete="off"
                                            class="vs__search @error('branch_id') is-invalid @enderror"
                                            :required="!branch_id"
                                            v-bind="attributes"
                                            v-on="events"
                                    />
                                </template>
                            </v-select>
                            <input type="hidden" name="branch_id"
                                v-model="branch_id">
                            @error('branch_id')
                            <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                            @enderror
                        </div>                        
                        <div class="form-group">
                            <label for="expense_chart_of_account_id"
                                class="control-label">{{trans_choice('accounting::general.expense',1)}}

                            </label>
                            <v-select label="name" :options="expenses"
                                    :reduce="expense => expense.id"
                                    v-model="expense_chart_of_account_id">
                                <template #search="{attributes, events}">
                                    <input
                                            autocomplete="off"
                                            class="vs__search @error('expense_chart_of_account_id') is-invalid @enderror"
                                            v-bind="attributes"
                                            v-on="events"
                                    />
                                </template>
                            </v-select>
                            <input type="hidden" name="expense_chart_of_account_id"
                                v-model="expense_chart_of_account_id">
                            @error('expense_chart_of_account_id')
                            <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="currency_id"
                                class="control-label">{{trans_choice('core::general.currency',1)}}
                            </label>
                            <v-select label="name" :options="currencies"
                                    :reduce="currency => currency.id" 
                                    v-model="currency_id" >
                                <template #search="{attributes, events}">
                                    <input
                                            autocomplete="off"
                                            class="vs__search @error('currency_id') is-invalid @enderror"
                                            :required="!currency_id"
                                            v-bind="attributes"
                                            v-on="events"
                                    />
                                </template>
                            </v-select>
                            <input type="hidden" name="currency_id"
                                v-model="currency_id">
                            @error('currency_id')
                            <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="amount" class="control-label">{{trans_choice('expense::general.amount',1)}}</label>
                            <input type="text" name="amount" v-model="amount"
                                id="amount"
                                class="form-control numeric @error('amount') is-invalid @enderror" required>
                            @error('amount')
                            <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                            @enderror
                        </div>                    
                        <div class="form-group">
                            <label for="date"
                                class="control-label">{{trans_choice('core::general.date',1)}}</label>
                            <flat-pickr v-model="date" name="date"
                                        class="form-control @error('date') is-invalid @enderror"
                                        required></flat-pickr>
                            @error('date')
                            <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="payment_types"
                                class="control-label">{{trans_choice('core::general.payment_method',1)}}

                            </label>
                            <v-select label="name" :options="payments"
                                    :reduce="payment => payment.id"
                                    v-model="payment_type_id">
                                <template #search="{attributes, events}">
                                    <input
                                            autocomplete="off"
                                            class="vs__search @error('payment_type_id') is-invalid @enderror"
                                            v-bind="attributes"
                                            v-on="events"
                                    />
                                </template>
                            </v-select>
                            <input type="hidden" name="payment_type_id"
                                v-model="payment_type_id">
                            @error('payment_type_id')
                            <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="receipt" class="control-label">{{trans_choice('core::general.receipt',1)}}</label>
                            <input type="text" name="receipt" v-model="receipt"
                                id="receipt"
                                class="form-control numeric @error('receipt') is-invalid @enderror" required>
                            @error('receipt')
                            <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="recurring"
                                class="control-label">{{trans_choice('expense::general.recurring',1)}}</label>
                            <select class="form-control @error('recurring') is-invalid @enderror" name="recurring"
                                    id="recurring"
                                    v-model="recurring" required>
                                <option value="0">{{trans_choice('core::general.no',1)}}</option>
                                <option value="1">{{trans_choice('core::general.yes',1)}}</option>
                            </select>
                            @error('recurring')
                            <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                            @enderror
                        </div>

                        <div class="row" v-show="recurring==1">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="recur_frequency"
                                        class="control-label">{{trans_choice('expense::general.recur_frequency',1)}}</label>
                                    <input type="number" name="recur_frequency" id="recur_frequency"
                                        class="form-control @error('recur_frequency') is-invalid @enderror numeric"
                                        v-model="recur_frequency"
                                        v-bind:required="recurring==1">
                                    @error('tenant_id')
                                    <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="recur_type"
                                        class="control-label">{{trans_choice('expense::general.recur_type',1)}}</label>
                                    <select class="form-control @error('recur_type') is-invalid @enderror"
                                            name="recur_type"
                                            id="recur_type"
                                            v-model="recur_type">
                                        <option value="day">{{trans_choice('expense::general.day',1)}}</option>
                                        <option value="week">{{trans_choice('expense::general.week',1)}}</option>
                                        <option value="month">{{trans_choice('expense::general.month',1)}}</option>
                                        <option value="year">{{trans_choice('expense::general.year',1)}}</option>
                                    </select>
                                    @error('recur_type')
                                    <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="recur_start_date"
                                        class="control-label">{{trans_choice('expense::general.recur_start_date',1)}}</label>
                                    <flat-pickr v-model="recur_start_date" name="recur_start_date" id="recur_start_date"
                                                class="form-control  @error('recur_start_date') is-invalid @enderror"
                                                v-bind:required="recurring==1"></flat-pickr>
                                    @error('recur_start_date')
                                    <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="recur_end_date"
                                        class="control-label">{{trans_choice('expense::general.recur_end_date',1)}}</label>
                                    <flat-pickr v-model="recur_end_date" name="recur_end_date" id="recur_end_date"
                                                class="form-control  @error('recur_end_date') is-invalid @enderror"></flat-pickr>
                                    @error('recur_end_date')
                                    <span class="invalid-feedback" role="alert">
                                            <strong>{{ $message }}</strong>
                                        </span>
                                    @enderror
                                </div>
                            </div>

                        </div>

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
                    <div class="card-footer border-top ">
                        <button type="submit"
                                class="btn btn-primary  float-right">{{trans_choice('core::general.save',1)}}</button>
                    </div>
                </div>
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
                expense_type_id: "{{old('expense_type_id')}}",
                payment_type_id: "{{old('payment_type_id')}}",
                currency_id: "{{old('currency_id')}}",
                branch_id: "{{old('branch_id')}}",
                amount: "{{old('amount')}}",
                date: "{{old('date',date('Y-m-d'))}}",
                recurring: "{{old('recurring',0)}}",
                recur_frequency: "{{old('recur_frequency',1)}}",
                recur_start_date: "{{old('recur_start_date')}}",
                recur_end_date: "{{old('recur_end_date')}}",
                recur_next_date: "{{old('recur_next_date')}}",
                recur_type: "{{old('recur_type','month')}}",
                description: "{{old('description')}}",
                expense_chart_of_account_id: "{{old('expense_chart_of_account_id')}}",
                asset_chart_of_account_id: "{{old('asset_chart_of_account_id')}}",
                expense_types: {!! json_encode($expense_types) !!},
                expenses: {!! json_encode($expenses) !!},
                assets: {!! json_encode($assets) !!},
                currencies: {!! json_encode($currencies) !!},
                branches: {!! json_encode($branches) !!},
                payments: {!! json_encode($payments) !!},
            },
            methods: {
                change_expense_type() {
                    this.expense_types.forEach(item => {
                        if (item.id == this.expense_type_id) {
                            if (!this.expense_chart_of_account_id) {
                                this.expense_chart_of_account_id = item.expense_chart_of_account_id;
                            }
                            if (!this.asset_chart_of_account_id) {
                                this.asset_chart_of_account_id = item.asset_chart_of_account_id;
                            }
                        }
                    });
                }
            }
        })
    </script>
@endsection