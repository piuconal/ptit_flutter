import 'dart:io';

import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, this.imagePath});
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Container(
        height: 150,
        width: 150,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
        child: imagePath == null
            ? const Icon(Icons.image)
            : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(File(imagePath!),fit:BoxFit.cover),
              ),
      ),
    );
  }
}
