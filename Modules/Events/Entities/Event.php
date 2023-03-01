<?php

namespace Modules\Events\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Client\Entities\Group;

class Event extends Model
{
    protected $fillable = ['name', 'start', 'end', 'user_id', 'group_id', 'branch_id', 'notes', 'location'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function group()
    {
        return $this->belongsTo(Group::class, 'group_id', 'id');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}
