<style>
    body{
        font-size: 9px;
        
    }
    html{
        /* margin: 20px 10px 5px 10px; */
    }
    .table {
        width: 100%;
        border: 1px solid #ccc;
        border-collapse: collapse;
    }

    table {
    font-family: arial, sans-serif;
    font-size: 10px;
    border-collapse: collapse;
    width: 100%;
    }

    td, th {
    border: 0.1em solid #000;
    text-align: left;
    padding: 2px;
    }

    tr{
        height: 20px;
    }


    .table th, td {
        padding: 2px;
        text-align: left;
        border: 1px solid #000;
    }

    .light-heading th {
        background-color: #eeeeee
    }

    .green-heading th {
        background-color: #4CAF50;
        color: white;
    }

    .text-center {
        text-align: center;
    }

    .table-striped tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .text-danger {
        color: #a94442;
    }
    .text-success {
        color: #3c763d;
    }
    th,td {
                height: 20px !important;
                /* vertical-align: middle !important; */
                }

                table{
                    margin-bottom: 0px !important;
                }
                .bamboo tr:nth-child(1) {
                    border-bottom: 1px solid #CCC;
                }
                .width-border{
                    width: 14%; 
                    border-left: 1px solid #e3e3e3;
                }

</style>
@include('core::themes.adminlte.letterhead.index')
&nbsp;
<table>
    <tr>
        <td style="width: 25%;">GROUP NAME</td>
        <td style="width: 25%;">{{Modules\Client\Entities\Group::find($group_id)->group_name}}</td>
        <td style="width: 25%;">PROJECT</td>
        <td style="width: 25%;"></td>
    </tr>
    <tr>
        <td style="width: 25%;">OFFICER NAME</td>
        <td style="width: 25%;"></td>
        <td style="width: 25%;">DATE</td>
        <td style="width: 25%;"></td>
    </tr>
    <tr>
        <td style="width: 25%;">SIGNATURE NAME</td>
        <td style="width: 25%;"></td>
        <td style="width: 25%;"></td>
        <td style="width: 25%;"></td>
    </tr>
</table>
&nbsp;
                    <table>
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
                            <th></th>
                            <th colspan="2" style="text-transform: uppercase; text-align: center">Collection</th>
                            <th colspan="5" style="text-transform: uppercase; text-align: center">Loans</th>
                            <th colspan="3" style="text-transform: uppercase; text-align: center">Savings</th>
                            <th></th>
                            <!-- <th></th> -->
                            <!-- <th colspan="3">{{trans_choice('core::general.start_date',1)}}: {{$start_date}}</th> -->
                            <!-- <th colspan="2">{{trans_choice('core::general.end_date',1)}}: {{$end_date}}</th> -->
                        </tr>
                        <tr style="background-color: #D1F9FF">
                            <th></th>
                            <th>{{trans_choice('client::general.client',1)}}</th>
                            <th>Cash</th>
                            <th>Non Cash</th>
                            <th>#</th>
                            <th>B/F</th>
                            <th>Principal</th>
                            <th>Interest</th>
                            <th>Repaid</th>
                            <th colspan="3" style="text-align: center">{{ trans_choice('savings::general.savings',1) }}</th>
                            <th>Others</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php
                        $total_due = 0;
                        $total_principal_nawiri = 0;
                        $total_principal_pap = 0;
                        $total_carried_down = 0;
                        $total_interest = 0;
                        $total_principal_repaid = 0;
                        $total_interest_repaid = 0;
                        $total_expected_amount = 0;
                        $total_savings = 0;
                        ?>   
                       
                        @foreach($clients as $key)
                            <?php
                                // if(@$key->loan_product->id = 1){
                                    foreach($key->loans as $loan)
                                    {
                                        if(@$key->loan_product->id == 1)
                                        {
                                            foreach($loan->repayment_schedules as $schedule){
                                                $total_principal_nawiri = $total_principal_nawiri + $schedule->principal_balance;
                                            }
                                        }

                                        if(@$key->loan_product->id == 2)
                                        {
                                            foreach($loan->repayment_schedules as $schedule){
                                                $total_principal_pap = $total_principal_pap + $schedule->principal_balance;
                                            }
                                        }
                                    }
                                 
                            ?>

                            @php $loans = count($key->loans); $count = $loans; @endphp
                            @php $save = count($key->savings) @endphp
                            @php $count =  max($loans, $save) @endphp
                            <tr >
                                <td style="width: 3%;" rowspan="{{$count}}">{{$key->id}}</td>
                                <td rowspan="{{$count}}" >{{ $key->name }}</td>
                                <td></td>
                                <td></td>
                                <td>{{@$key->loans[0]->loan_product->name}}</td>
                                <td>{{number_format(@$key->loans[0]->repayment_schedules[0]->principal_balance, 2)}}</td>
                                <td>{{number_format(@$key->loans[0]->repayment_schedules[0]->principal, 2)}}</td>
                                <td>{{number_format(@$key->loans[0]->repayment_schedules[0]->interest, 2)}}</td>
                                <td></td>
                                <td>{{@$key->savings[0]->savings_product->short_name}}</td>
                                <td>{{number_format(@$key->savings[0]->balance_derived, 2)}}</td>
                                <td></td>
                                <td></td>
                            </tr>
                            @for($i = 1; $i < $count; $i++)                            
                                <tr>
                                    <!-- <td></td> -->
                                    <!-- <td></td> -->
                                    <td></td>
                                    <td></td>
                                    <td>{{@$key->loans[$i]->loan_product->name}}</td>
                                    <td>{{number_format(@$key->loans[$i]->repayment_schedules[0]->principal_balance, 2)}}</td>
                                    <td>{{number_format(@$key->loans[$i]->repayment_schedules[0]->principal, 2)}}</td>
                                    <td>{{number_format(@$key->loans[$i]->repayment_schedules[0]->interest, 2)}}</td>
                                    <td></td>
                                    <td>{{@$key->savings[$i]->savings_product->short_name}}</td>
                                    <td>{{number_format(@$key->savings[$i]->balance_derived, 2)}}</td>  
                                    <td style="width: 5%;"></td>
                                    <td></td>                      
                                    
                                </tr>
                            @endfor
                        @endforeach
                        </tbody>
                        <tfoot>
                            <tr>
                                <td></td>
                                <td><b>{{trans_choice('core::general.total',1)}}</b></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>{{number_format($total_carried_down,2)}}</td>
                                <td>{{number_format($total_principal_nawiri,2)}}</td>
                                <td>{{number_format($total_interest,2)}}</td>
                                <td>{{number_format($total_principal_repaid + $total_interest_repaid,2)}}</td>
                                <td>{{number_format($total_due,2)}}</td>
                                <td>{{number_format($total_savings, 2)}}</td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>

                    <table style="margin-top: 30px; border: 0px solid #fff">
                        <tbody>
                            <tr>
                                <td style="width: 45%">
                                    <table>
                                    <thead>
                                        <tr>
                                            <th colspan="2">LOANS SUMMARY</th>                                
                                        </tr>
                                    </thead>
                                    <?php $total_loans = 0; ?>
                                    <tbody>
                                        @foreach($sum as $sm)
                                        <?php $total_loans = $total_loans + $sm->balance; ?>
                                            <tr>
                                                <td>{{$sm->name}}</td>
                                                <td>{{number_format($sm->balance, 2)}}</td>
                                            </tr>
                                        @endforeach
                                        <tr style="border: 0px solid #fff">
                                            <td></td>
                                            <td><strong>{{number_format($total_loans, 2)}}</strong></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                                <td style="width: 10%"></td>
                                <td style="width: 45%">
                                <table>
                                    <thead>
                                        <tr>
                                            <th colspan="2">SAVINGS SUMMARY</th>                                
                                        </tr>
                                    </thead>
                                    <?php $total_savings  = 0; ?>
                                    <tbody>
                                        @foreach($sum2 as $sm)
                                        <?php $total_savings = $total_savings + $sm->balance; ?>
                                            <tr>
                                                <td>{{$sm->name}}</td>
                                                <td>{{number_format($sm->balance, 2)}}</td>
                                            </tr>
                                        @endforeach
                                        <tr style="border: 0px solid #fff">
                                            <td></td>
                                            <td><strong>{{number_format($total_savings, 2)}}</strong></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                        
                    </table>
