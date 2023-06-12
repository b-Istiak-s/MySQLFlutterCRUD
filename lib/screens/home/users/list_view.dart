import 'package:flutter/material.dart';

Widget userListView({
  required dynamic user,
}) {
  String? imageUrl;
  if (user.image != null && user.image.isNotEmpty) {
    if (Uri.parse(user.image).isAbsolute) {
      // If the image is already a URL, use it directly
      imageUrl = user.image;
    } else {
      // If the image is a file path, convert it to a URL
      imageUrl = Uri.file(user.image).toString();
    }
  }
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
      child: imageUrl == null ? const Icon(Icons.no_accounts) : null,
    ),
    title: Text(
      user.name,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      user.phoneNumber,
      style: const TextStyle(fontStyle: FontStyle.italic),
    ),
  );
}
