import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql_crud_flutter/model/sign_up_user.dart';
import 'package:mysql_crud_flutter/screens/home/home_activity.dart';

import '../../widgets/Text/custom_text_field.dart';

class SignUpLayout extends StatefulWidget {
  const SignUpLayout({Key? key}) : super(key: key);

  @override
  State<SignUpLayout> createState() => _SignUpLayoutState();
}

class _SignUpLayoutState extends State<SignUpLayout> {
  late TextEditingController phoneNumberController = TextEditingController(),
      passwordController = TextEditingController(),
      fullNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? fullNameErrorText;
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
              "Sign up in CRUD application",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
            ))),
        Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 2),
            child: textFields()),
        ElevatedButton(
            onPressed: () {
              setState(() {
                fullNameErrorText = validateFullName(fullNameController.text);
                phoneNumberErrorText =
                    validatePhoneNumber(phoneNumberController.text);
                passwordErrorText = validatePassword(passwordController.text);
              });
              if (fullNameController.text.isNotEmpty &&
                  phoneNumberController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                SignUp signUp = SignUp(
                    name: fullNameController.text,
                    phoneNumber: phoneNumberController.text,
                    password: passwordController.text);
                signUp.createUser().then((response) {
                  if (response.statusCode == 201) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomeActivity(title: 'Home')),
                    );
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
                  Fluttertoast.showToast(msg: error);
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
            child: const Text("Sign up"))
      ]),
    );
  }

  Widget textFields() {
    return Column(children: [
      customTextField(
        labelText: "Enter your full name",
        controller: fullNameController,
        validator: fullNameErrorText,
      ),
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

  String? validateFullName(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter your full name';
    }
    return null;
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
