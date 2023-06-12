import 'package:flutter/material.dart';
import 'package:mysql_crud_flutter/model/user_model.dart';
import 'package:mysql_crud_flutter/screens/home/users/list_view.dart';
import 'package:mysql_crud_flutter/screens/home/users/user_details.dart';
import 'package:mysql_crud_flutter/screens/user/auth_user.dart';

import '../../model/shared_preference.dart';

class HomeActivity extends StatefulWidget {
  final String title;
  const HomeActivity({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    List<UserModel>? fetchedUsers = await UserModel.fetchUsers();
    // ignore: unnecessary_null_comparison
    if (fetchedUsers != null) {
      setState(() {
        users = fetchedUsers;
      });
    } else {
      // Handle the case when fetchedUsers is null
      // Show an error message or take appropriate action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Row(children: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserDetails(
                              user: null,
                              title: "My profile",
                            )),
                    (route) => false);
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                saveLoginInfo("", "");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthUser()),
                    (route) => false);
              },
            )
          ]),
        ],
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return userListView(user: users[index]);
          }),
    );
  }
}
