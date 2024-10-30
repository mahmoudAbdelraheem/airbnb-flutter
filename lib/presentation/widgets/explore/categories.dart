import 'package:airbnb_flutter/data/models/category_model.dart';
import 'package:airbnb_flutter/logic/explore/explore_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/category.dart';
import 'package:flutter/material.dart';

class Categoties extends StatefulWidget {
  final List<CategoryModel> categoties;
  final ExploreBloc exploreBloc;
  const Categoties({
    required this.categoties,
    required this.exploreBloc,
    super.key,
  });

  @override
  State<Categoties> createState() => _CategotiesState();
}

class _CategotiesState extends State<Categoties> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoties.length,
        itemBuilder: (_, index) {
          return Category(
            category: widget.categoties[index],
            isSelected: selectedIndex == index,
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });

              widget.exploreBloc.add(
                GetListingByCategoryEvent(
                  categoryId: widget.categoties[index].id,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
