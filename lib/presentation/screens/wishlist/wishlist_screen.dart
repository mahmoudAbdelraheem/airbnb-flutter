import 'package:airbnb_flutter/presentation/widgets/screens_header.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: const [
        SizedBox(height: 20),
        ScreensHeader(
          mainTitle: 'Wishlists',
          title: "Login to view your wishlists",
          subtitle:
              "you cat create, view, or edit your wishlist once you've logged in.",
        ),
      ],
    );
  }
}
