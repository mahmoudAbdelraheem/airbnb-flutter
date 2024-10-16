import 'package:airbnb_flutter/presentation/widgets/explore/categories.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/search.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(bottom: 10),
      height: 160,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ]),
      child: Column(
        children: [
          Search(onPressed: () {}),
          const Categoties(),
        ],
      ),
    );
  }
}
