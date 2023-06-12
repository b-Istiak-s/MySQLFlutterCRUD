import 'dart:convert';

import 'package:http/http.dart' as http;

class UserModel {
  final String name, phoneNumber, dob, image, location, createdAt, updatedAt;

  UserModel(
      {required this.name,
      required this.phoneNumber,
      required this.dob,
      required this.image,
      required this.location,
      required this.createdAt,
      required this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      dob: json['dob'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  static Future<List<UserModel>> fetchUsers() async {
    const url = "http://192.168.31.11:8000/api/user";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    final List<UserModel> users = [];
    for (var userJson in json['users']) {
      final user = UserModel.fromJson(userJson);
      users.add(user);
    }
    return users;
  }
}
