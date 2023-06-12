import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql_crud_flutter/widgets/Text/custom_text_field.dart';

class UserDetails extends StatefulWidget {
  final dynamic user;
  final String title;
  const UserDetails({super.key, required this.user, required this.title});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late TextEditingController phoneNumberController = TextEditingController(),
      passwordController = TextEditingController(),
      fullNameController = TextEditingController();
  File? _selectedImage = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              backgroundImage: _selectedImage == null
                  ? const NetworkImage(
                          "http://192.168.31.11:8000/storage/image/menimage11.jpg")
                      as ImageProvider<Object>?
                  : FileImage(_selectedImage!),
              radius: 100,
            )),
        customTextField(
            labelText: "Enter your name", controller: fullNameController),
        customTextField(
            labelText: "Enter your name", controller: fullNameController),
      ]),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    pickedImage != null
        ? setState(() {
            _selectedImage = File(pickedImage.path);
          })
        : null;
  }
}
