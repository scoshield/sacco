<?php

namespace Modules\Core\Http\Controllers\Api\v1;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\User\Entities\Register;
use Modules\Core\Entities\PaymentDetail;
use Modules\Savings\Entities\SavingsTransaction;
use Modules\Loan\Entities\LoanTransaction;

class PaymentDetailController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api');
    }
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index()
    {
        return PaymentDetail::all();
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('core::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function payment_detail_transactions($id)
    {
        return view('core::show');
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function payment_detail_register_transactions($id, $register_id)
    {
        $data = PaymentDetail::join('registers',  'payment_details.register_id', 'registers.id')
                ->join('payment_types', 'payment_types.id', 'payment_details.payment_type_id')
                ->where('payment_details.register_id', $register_id)
                ->where('payment_types.id', $id)
                ->get();

                return response()->json($data);
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {
        return view('core::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        //
        $item = PaymentDetail::find($id);
        // check if the payment has loan transaction record
        $loan = LoanTransaction::where('payment_detail_id', $id)->first();
        $saving = SavingsTransaction::where('payment_detail_id', $id)->first();
        // $income  =Income::where

        if($loan || $saving)
        {
            return response()->json(["success" => false, "message" => 'The payment detail has transactions and can not be reversed.'], 400);
        }
        else
        {
            $item->delete();
            return response()->json(["success" => true, "message" => 'The payment detail has been deleted successfully.']);
        }
    }
}
