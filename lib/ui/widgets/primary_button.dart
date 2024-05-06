import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.height = 40,
    this.weight = 160,
    required this.onTap,
    this.fontSize = 18,
  });

  final double? height;
  final double? weight;
  final Function() onTap;
  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: weight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.red),
        child: Text(
          title,
          style:  TextStyle(
              color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
