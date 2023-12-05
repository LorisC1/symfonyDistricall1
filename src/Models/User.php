<?php

namespace App\Models;
// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{


        /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = ['firstname', 'email', 'lastname', 'isAdmin'];
    use HasApiTokens, HasFactory, Notifiable;


    /**
     * Determine if the user is an administrator.
     */
    protected function isAdmin() : bool  {
        return $this->isAdmin(); 
    }

    /**
     * Get the user's order history.
     */
    public function orders() {
        return $this->hasMany(Order::class, 'user_id')
            ->join('product', 'order.product_id', '=', 'product.id')
            ->join('order_status', 'order_status.id', '=', 'order.order_status_id')
            ->select('order.*', 'product.name as product_name', 'product.price as product_price', 'order_status.name as order_status_name');
    }
    
    public function getOrderHistory() {

        //            <p>{{ date('m/d/Y', $order->created_at )}}</p>

        return $this->orders()->get(); // Supprimez le get() ici
    }
    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];
}