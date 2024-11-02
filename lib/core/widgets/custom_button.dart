import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  final Color backgroundColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.backgroundColor = Colors.pink,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      minWidth: width,
      height: 45,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
