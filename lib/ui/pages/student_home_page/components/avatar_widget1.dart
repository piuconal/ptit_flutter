import 'dart:typed_data';

import 'package:flutter/material.dart';

class AvatarWidget1 extends StatelessWidget {
  const AvatarWidget1({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.red, width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 280,
        width: 230,
        decoration:
            BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey[300]),
        child: imageUrl == null
            ? const Icon(Icons.image)
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
