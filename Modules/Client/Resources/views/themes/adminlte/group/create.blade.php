@extends('core::layouts.master')
@section('title')
    {{ trans_choice('core::general.add',1) }} {{ trans_choice('client::general.group',1) }}
@endsection
@section('content')
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>
                        {{ trans_choice('core::general.add',1) }} {{ trans_choice('client::general.group',1) }}
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
                                    href="{{url('client/group')}}">{{ trans_choice('client::general.group',2) }}</a>
                        </li>
                        <li class="breadcrumb-item active">{{ trans_choice('core::general.add',1) }} {{ trans_choice('client::general.group',1) }}</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>
    <section class="content" id="app">
        <form method="post" action="{{ url('client/group/store') }}">
            {{csrf_field()}}
            <div class="card card-bordered card-preview">
                <div class="card-body">
                    <div class="row gy-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="name"
                                       class="control-label">{{trans_choice('core::general.name',1)}}</label>
                                <input type="text" name="group_name" v-model="group_name"
                                       id="group_name"
                                       class="form-control @error('group_name') is-invalid @enderror" required>
                                @error('group_name')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="row gy-4">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="name"
                                       class="control-label">{{trans_choice('client::general.venue',1)}}</label>
                                <input type="text" name="venue" v-model="venue"
                                       id="venue"
                                       class="form-control @error('venue') is-invalid @enderror" required>
                                @error('group_name')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="row gy-4">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="name"
                                       class="control-label">{{trans_choice('client::general.order',1)}}</label>
                                <input type="number" min="1" max="4" name="order_of_the_day" v-model="order_of_the_day"
                                       id="order_of_the_day"
                                       class="form-control @error('order_of_the_day') is-invalid @enderror" required>
                                @error('group_name')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="name"
                                       class="control-label">{{trans_choice('client::general.week_day',1)}}</label>
                                <select type="text" name="day_of_the_week" v-model="day_of_the_week"
                                       id="order"
                                       class="form-control @error('day_of_the_week') is-invalid @enderror" required>
                                       <option value=""></option>
                                       <option value="monday">Monday</option>
                                       <option value="tuesday">Tuesday</option>
                                       <option value="wednesday">Wednesday</option>
                                       <option value="thursday">Thursday</option>
                                       <option value="friday">Friday</option>
                                       <option value="saturday">Saturday</option>
                                       <option value="sunday">Sunday</option>
                                </select>
                                @error('group_name')
                                <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="name"
                                       class="control-label">{{trans_choice('client::general.frequency',1)}}</label>
                                <select type="text" name="meeting_frequency" v-model="meeting_frequency"
                                       id="order"
                                       class="form-control @error('meeting_frequency') is-invalid @enderror" required>
                                       <option value=""></option>
                                       <option value="daily">Daily</option>
                                       <option value="weekly">Weekly</option>
                                       <option value="monthly">Monthly</option>
                                </select>
                                @error('group_name')
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

            }
        })
    </script>
@endsection