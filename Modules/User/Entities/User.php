<?php

namespace Modules\User\Entities;

use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Passport\HasApiTokens;
// use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guard_name = 'web';
    protected $fillable = [
        'name', 'email', 'password', 'first_name', 'last_name', 'username', 'enable_google2fa', 'google2fa_secret', 'phone', 'address', 'city', 'gender', 'api_token', 'notes', 'branch_id', 'email_verified_at', 'last_login', 'photo', 'user_control_account', 'status'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token', 'google2fa_secret', 'api_token'
    ];
    protected $appends = [
        'full_name'
    ];
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function getFullNameAttribute()
    {
        return $this->first_name . ' ' . $this->last_name;
    }

    public function registers(){
        return $this->hasMany(Register::class);
    }

    public function events()
    {
        return $this->hasMany(Event::class);
    }

    // public function latestRegister()
    // {
    //     return $this->hasOne(Register::class)->latestOfMany();
    // }
}
