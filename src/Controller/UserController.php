<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Log;
use App\Models\User;
use App\Http\Requests\StoreLoginRequest;
use App\Http\Requests\StoreRegisterRequest;
use App\Http\Requests\StoreEditProfileRequest;

class UserController
{
    // ... Vos autres fonctions

    public function postRegister($request) {
        $user = new User();
        $user->email = $request->input('email');
        $user->firstname = $request->input('firstname');
        $user->lastname = $request->input('lastname');
        $user->password = bcrypt($request->input("password"));
        $validEmail = User::where("email", $user->email)->count() === 0;

        if ($validEmail && $user->save()) {
            return $this->getLogin(); // Utilisation de $this pour appeler la méthode du même contrôleur
        } else {
            return $this->getRegister(true);
        }
    }

    public function getLogin($bad = false) {
        if ( session()->has('user') ) {
            return redirect()->action('HomeController@getIndex');
        } else {
            return view('login', ["bad" => $bad]);
        }  
    }

    public function postLogin(StoreLoginRequest $request) {
        $email = $request->input("email");
        $password = $request->input("password");

        $user = User::where("email", $email)->first();

        if ($user && password_verify($password, $user->password)) {
            session(['user' => $user]);
            return view('homepage', []);
        } else {
            return self::getLogin(true);
        }
    }

    public function getProfil($bad = false) {
        if (session()->has('user')) {
            $user = session()->get('user');
            return view('profil2', [
                "firstname" => $user->firstname,
                "lastname" => $user->lastname,
                "email" => $user->email,
                "isAdmin" => $user->isAdmin,
                "bad" => $bad
            ]);
        } else {
            return redirect()->action('HomeController@getIndex');
        }   
    }

    public function postProfil(StoreEditProfileRequest $request) {
        if ( session()->has('user')) {


            $newFirstName = $request->input('firstname');
            $newLastName = $request->input('lastname');
            $newEmail = $request->input('email');
            $user = session()->get('user');


            if ($user->email===$newEmail) {
                return view('homepage', []);
            }
            else if ( User::where("email", $newEmail)->count() === 0 ) {
                $user->update([
                    "firstname" => $newFirstName,
                    "email" => $newEmail,
                    "lastname" => $newLastName
                ]);
    
                session(['user' => $user]);
    
                return view('homepage', []);
            } else {
                return self::getProfil(true); 
            }
            
        } else {
            return view('homepage', ["bad" => false]);
        }
    }

    public function getHistory() {
        if ( session()->has("user") ) {
            
            $user = session()->get('user'); 
            $orders = $user->getOrderHistory() ;
            return view('history', ["orders" => $orders, "isAdmin" => $user->isAdmin]); 
        } else {
            return view('homepage',[]); 
        }
    }

    public function disconnect() {
        if ( session()->has("user")) {
            session()->forget('user');
            return view('homepage', []);
        }
    }
}
