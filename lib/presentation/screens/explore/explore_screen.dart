import 'package:airbnb_flutter/presentation/widgets/explore/nav_bar.dart';
import 'package:airbnb_flutter/presentation/widgets/explore/listing_card.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NavBar(),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return const ListingCard();
            },
          ),
        ),
      ],
    );
  }
}
