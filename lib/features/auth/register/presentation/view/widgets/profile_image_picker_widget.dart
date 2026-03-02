import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePickerWidget extends StatelessWidget {
  final XFile? imageFile;
  final VoidCallback onTap;

  const ProfileImagePickerWidget({
    super.key,
    required this.onTap,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: imageFile != null ? FileImage(File(imageFile!.path)) : null,
        child: imageFile == null ? const Icon(Icons.camera_alt, size: 40) : null,
      ),
    );
  }
}