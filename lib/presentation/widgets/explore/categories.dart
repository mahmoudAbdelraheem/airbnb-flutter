import 'package:airbnb_flutter/presentation/widgets/explore/category.dart';
import 'package:flutter/material.dart';

class Categoties extends StatelessWidget {
  const Categoties({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (_, index) {
            return const Category();
          }),
    );
  }
}
