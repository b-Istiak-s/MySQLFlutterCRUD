<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateuserRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'name' => 'string',
            'dob' => 'string',
            'password' => 'string',
            'image' => 'string',
            'location' => 'string',
            'phone_number' => 'string',
        ];
    }
}
