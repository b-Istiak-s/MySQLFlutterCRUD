import 'package:flutter/material.dart';
import 'package:mysql_crud_flutter/screens/user/sign_up.dart';

import 'login.dart';

class AuthUser extends StatefulWidget {
  const AuthUser({super.key});

  @override
  State<AuthUser> createState() => _AuthUserState();
}

class _AuthUserState extends State<AuthUser> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.account_circle),
                ),
                Tab(
                  icon: Icon(Icons.login),
                ),
              ]),
              title: const Text("Auth User")),
          body: const TabBarView(children: [
            SignUpLayout(),
            LoginLayout(),
          ]),
        ));
  }
}
