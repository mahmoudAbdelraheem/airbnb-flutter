import 'package:airbnb_flutter/presentation/widgets/screens_header.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: const [
        SizedBox(height: 20),
        ScreensHeader(
          mainTitle: 'Your Profile',
          title: "",
          subtitle: "Log in to start planning your next trip.",
          btnWidth: double.infinity,
        ),
      ],
    );
  }
}
