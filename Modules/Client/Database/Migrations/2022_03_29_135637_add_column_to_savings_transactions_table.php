<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddColumnToSavingsTransactionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('savings_transactions', function (Blueprint $table) {
            // $table->unsignedBigInteger('register_id')->after('savings_id')->default(1);
            // $table->foreign('register_id')->references(('id'))->on('registers')->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('savings_transactions', function (Blueprint $table) {

        });
    }
}
