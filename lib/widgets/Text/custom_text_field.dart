import 'package:flutter/material.dart';

Widget customTextField({
  required String labelText,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  bool isPassword = false,
  String? validator,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 20, 10, 2),
    child: TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: (value) => validator,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorText: validator,
      ),
      keyboardType: keyboardType,
    ),
  );
}
