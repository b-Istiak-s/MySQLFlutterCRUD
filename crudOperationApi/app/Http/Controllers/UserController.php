<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreuserRequest;
use App\Http\Requests\UpdateuserRequest;
use App\Models\user;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function index()
    {
        $users = user::all();
        return response()->json(['users' => $users], 200);
    }

    public function store(StoreuserRequest $request)
    {
        $number = $request->get('phone_number');
        try {
            $userCount = count(DB::select('select * from users where phone_number = ?', [$number]));
            if ($userCount == 0) {
                $userData = $request->all();
                $userData['password'] = Hash::make($userData['password']);
                $user = user::create($userData);
                return response()->json(['user' => $user], 201);
            }else{
                return response()->json(['value' => "failure", "message" => "The phone number already exists in database."],201);
            }
        } catch (\Illuminate\Database\QueryException $exception) {
            $errorCode = $exception->errorInfo[1];

            if ($errorCode == 1062) {
                return response()->json(['message' => 'The phone number already exists in the database.'], 500);
            }

            // Handle other query exceptions if needed

            // Return a generic error response
            return response()->json(['message' => 'An error occurred.'], 500);
        }
    }

    public function login(Request $request){
        $credentials = $request->only('phone_number', 'password');

        $user = User::where('phone_number', $credentials['phone_number'])->first();

        if (!$user || !Hash::check($credentials['password'], $user->password)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        // Authentication successful
        // You can generate a token or perform any other necessary actions

        return response()->json(['message' => 'Login successful'], 201);
    }

    public function show($id)
    {
        $user = user::findOrFail($id);
        return response()->json(['user' => $user], 200);
    }

    public function update(UpdateuserRequest $request, $id)
    {
        $user = user::findOrFail($id);
        $user['password'] = Hash::make($user['password']);
        $user->update($request->all());
        return response()->json(['user' => $user], 200);
    }

    public function destroy($id)
    {
        $user = user::findOrFail($id);
        $user->delete();
        return response()->json(null, 204);
    }
}
