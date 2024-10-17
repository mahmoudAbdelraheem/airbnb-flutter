import 'package:airbnb_flutter/data/models/category_model.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/category.dart';
import 'package:flutter/material.dart';

class Categoties extends StatelessWidget {
  final List<CategoryModel> categoties;
  const Categoties({
    required this.categoties,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoties.length,
          itemBuilder: (_, index) {
            return Category(
              category: categoties[index],
            );
          }),
    );
  }
}
