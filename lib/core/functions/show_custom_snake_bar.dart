import 'package:flutter/material.dart';

showCustomSnakeBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      clipBehavior: Clip.none,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
