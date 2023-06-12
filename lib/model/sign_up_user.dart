import 'dart:convert';

import 'package:http/http.dart' as http;

class SignUp {
  final String name, phoneNumber, password;

  SignUp(
      {required this.name, required this.phoneNumber, required this.password});

  Future<http.Response> createUser() {
    return http.post(
      Uri.parse('http://192.168.31.11:8000/api/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phone_number': phoneNumber,
        'password': password,
      }),
    );
  }
}
