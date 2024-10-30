import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  const MyIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}
