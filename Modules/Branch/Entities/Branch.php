<?php

namespace Modules\Branch\Entities;

use Illuminate\Database\Eloquent\Model;

class Branch extends Model
{
    protected $table = "branches";


    public function users()
    {
        return $this->hasMany(BranchUser::class, 'branch_id', 'id');
    }

    public function events()
    {
        return $this->hasMany(Event::class);
    }

    public function groups()
    {
        return $this->hasMany(Group::class);
    }
}
