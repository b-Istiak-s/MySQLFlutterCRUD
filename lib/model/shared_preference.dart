import 'package:shared_preferences/shared_preferences.dart';

// Save user login information
Future<void> saveLoginInfo(String phoneNumber, String password) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('phoneNumber', phoneNumber);
  prefs.setString('password', password);
}

// Retrieve user login information
Future<Map<String, String?>> getLoginInfo() async {
  final prefs = await SharedPreferences.getInstance();
  final phoneNumber = prefs.getString('phoneNumber');
  final password = prefs.getString('password');
  return {'phoneNumber': phoneNumber, 'password': password};
}
