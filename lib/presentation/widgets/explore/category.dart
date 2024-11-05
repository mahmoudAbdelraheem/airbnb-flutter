import 'package:airbnb_flutter/data/models/category_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Category extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onPressed;
  final bool isSelected;
  const Category({
    required this.category,
    super.key,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsetsDirectional.only(top: 10),
        margin: const EdgeInsetsDirectional.only(end: 15),
        decoration: isSelected
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              )
            : null,
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
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.black : Colors.grey.shade700,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (context) => Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 194, 184, 184),
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Text(category.label),
          ],
        ),
      ),
    );
  }
}
