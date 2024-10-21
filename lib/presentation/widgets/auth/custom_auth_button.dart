import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final String imagePath;
  final String bottonText;
  final VoidCallback onPressed;
  const CustomAuthButton({
    super.key,
    required this.imagePath,
    required this.bottonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 1.1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                imagePath,
                height: 35,
                width: 35,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: Text(
                bottonText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
