import 'package:airbnb_flutter/core/widgets/my_icon.dart';
import 'package:flutter/material.dart';

class ListingDetailsHeader extends StatelessWidget {
  const ListingDetailsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyIcon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
          ),
          MyIcon(
            onPressed: () {},
            icon: Icons.favorite_border_outlined,
          ),
        ],
      ),
    );
  }
}
