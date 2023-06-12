import 'dart:convert';

import 'package:http/http.dart' as http;

class Login {
  final String phoneNumber, password;

  Login({required this.phoneNumber, required this.password});

  Future<http.Response> login() {
    return http.post(
      Uri.parse('http://192.168.31.11:8000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone_number': phoneNumber,
        'password': password,
      }),
    );
  }
}
