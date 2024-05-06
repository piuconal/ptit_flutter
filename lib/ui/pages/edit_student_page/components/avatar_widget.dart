import 'dart:typed_data';

import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, this.imageSource, this.imageUrl});
  final Uint8List? imageSource;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Container(
        height: 230,
        width: 230,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
        child: imageSource == null && imageUrl==null
            ? const Icon(Icons.image)
            : ClipRRect(
                borderRadius: BorderRadius.circular(220),
                child: imageSource != null
                    ? Image.memory(imageSource!, fit: BoxFit.cover)
                    : Image.network(imageUrl!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
