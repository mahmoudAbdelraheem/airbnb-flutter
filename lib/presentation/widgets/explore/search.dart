import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final VoidCallback onPressed;
  const Search({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: const Card(
          shadowColor: Colors.black54,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  size: 26,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Where to?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    // SizedBox(height: 5),
                    Text(
                      'Anywhere . Any week . Add guests',
                      style: TextStyle(
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
