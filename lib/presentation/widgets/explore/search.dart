import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final String place;
  final String date;
  final String guest;
  final IconData icon;
  final VoidCallback onPressed;
  const Search({
    super.key,
    required this.onPressed,
    required this.place,
    required this.date,
    required this.guest,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          shadowColor: Colors.black54,
          elevation: 12,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Where to?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    // SizedBox(height: 5),
                    Text(
                      '$place . $date . $guest',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
