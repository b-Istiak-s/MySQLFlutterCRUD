import 'package:flutter/material.dart';
import 'package:mysql_crud_flutter/model/shared_preference.dart';
import 'package:mysql_crud_flutter/screens/home/home_activity.dart';
import 'package:mysql_crud_flutter/screens/user/auth_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLoginInfo(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final loginInfo = snapshot.data;

          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.deepPurple,
              ),
            ),
            home: loginInfo!['phoneNumber'] == null
                ? const AuthUser()
                : const HomeActivity(title: 'Home'),
          );
        }
      }),
    );
  }
}
