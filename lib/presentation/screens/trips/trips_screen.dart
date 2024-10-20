import 'package:airbnb_flutter/presentation/widgets/screens_header.dart';
import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: const [
        SizedBox(height: 20),
        ScreensHeader(
          mainTitle: 'Trips',
          title: "No trips yet",
          subtitle:
              "When you're ready to plan your next trip, we're here to help you!.",
        ),
      ],
    );
  }
}
