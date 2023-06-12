import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql_crud_flutter/model/shared_preference.dart';

import '../../model/login.dart';
import '../../widgets/Text/custom_text_field.dart';
import '../home/home_activity.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({super.key});

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  late TextEditingController phoneNumberController = TextEditingController(),
      passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumberErrorText;
  String? passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: const Center(
                child: Text(
              "Login in CRUD application",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
            ))),
        Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 2),
            child: textFields()),
        ElevatedButton(
            onPressed: () {
              setState(() {
                phoneNumberErrorText =
                    validatePhoneNumber(phoneNumberController.text);
                passwordErrorText = validatePassword(passwordController.text);
              });
              if (phoneNumberController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                Login login = Login(
                    phoneNumber: phoneNumberController.text,
                    password: passwordController.text);
                login.login().then((response) {
                  if (response.statusCode == 201) {
                    saveLoginInfo(
                        phoneNumberController.text, passwordController.text);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const HomeActivity(title: 'Home')),
                        (route) => false);
                  } else {
                    final responseBody = json.decode(response.body);
                    Fluttertoast.showToast(
                      msg: responseBody['message'],
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }).catchError((error) {
                  Fluttertoast.showToast(
                    msg: error.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                });
              }
              if (_formKey.currentState != null &&
                  !_formKey.currentState!.validate()) {
                Fluttertoast.showToast(
                  msg: "Form is invalid",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            child: const Text("Login"))
      ]),
    );
  }

  Widget textFields() {
    return Column(children: [
      customTextField(
        labelText: "Enter your phone number",
        controller: phoneNumberController,
        keyboardType: TextInputType.number,
        validator: phoneNumberErrorText,
      ),
      customTextField(
        labelText: "Enter password",
        controller: passwordController,
        isPassword: true,
        validator: passwordErrorText,
      ),
    ]);
  }

  String? validatePhoneNumber(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter your phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter a password';
    }
    return null;
  }
}
