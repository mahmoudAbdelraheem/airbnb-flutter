import 'package:airbnb_flutter/core/widgets/loading.dart';
import 'package:airbnb_flutter/data/models/category_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final CategoryModel category;
  const Category({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(top: 10),
      margin: const EdgeInsetsDirectional.only(end: 15),
      // decoration: BoxDecoration(
      // border: index == 0
      //     ? const Border(
      //         bottom: BorderSide(
      //           color: Colors.black,
      //           width: 2,
      //         ),
      //       )
      //     : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.network(
            category.image,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              // Colors.grey.shade700,
              Colors.black,
              BlendMode.srcIn,
            ),
            placeholderBuilder: (context) => const Loading(),
          ),
          Text(category.label),
        ],
      ),
    );
  }
}
