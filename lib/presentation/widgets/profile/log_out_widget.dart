import 'package:flutter/material.dart';

class LogOutWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const LogOutWidget({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.only(bottom: 10),
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
        child: const Text(
          "Log out",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
