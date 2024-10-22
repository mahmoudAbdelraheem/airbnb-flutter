import 'package:flutter/material.dart';

class ProfileBottonsBar extends StatelessWidget {
  final String lable;
  final IconData prefixIcon;
  final VoidCallback onPressed;
  const ProfileBottonsBar({
    super.key,
    required this.lable,
    required this.prefixIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  prefixIcon,
                  size: 26,
                ),
                const SizedBox(width: 20),
                Text(
                  lable,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
