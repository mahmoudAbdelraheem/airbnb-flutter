import 'package:flutter/material.dart';

class ExpandableSection extends StatelessWidget {
  final bool isExpanded;
  final String title;
  final String selectedValue;
  final VoidCallback onTap;
  final double height;
  final Widget child;

  const ExpandableSection({
    super.key,
    required this.isExpanded,
    required this.title,
    required this.selectedValue,
    required this.onTap,
    required this.child,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: isExpanded ? height : 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: isExpanded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  FutureBuilder(
                      future: Future.delayed(const Duration(seconds: 1)),
                      builder: (_, snapShots) {
                        if (snapShots.connectionState == ConnectionState.done) {
                          return child;
                        } else {
                          return Container();
                        }
                      }),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.toLowerCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  Text(
                    selectedValue,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
      ),
    );
  }
}
