import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/presentation/widgets/profile/log_out_widget.dart';
import 'package:airbnb_flutter/presentation/widgets/profile/profile_bottons_bar.dart';
import 'package:airbnb_flutter/presentation/widgets/screens_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const SizedBox(height: 20),
        const ScreensHeader(
          mainTitle: 'Your Profile',
          title: "",
          subtitle: "Log in to start planning your next trip.",
          btnWidth: double.infinity,
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            const Text('don\'t have an account? '),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppConstants.registerScreen);
              },
              child: const Text(
                'Sign up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ProfileBottonsBar(
          onPressed: () {},
          prefixIcon: Icons.settings_outlined,
          lable: 'Setting',
        ),
        ProfileBottonsBar(
          onPressed: () {},
          prefixIcon: Icons.accessibility_new_outlined,
          lable: 'Accessibility',
        ),
        ProfileBottonsBar(
          onPressed: () {},
          prefixIcon: Icons.help_outline,
          lable: 'Get Help',
        ),
        ProfileBottonsBar(
          onPressed: () {},
          prefixIcon: Icons.menu_book_rounded,
          lable: 'Terms of Service',
        ),
        ProfileBottonsBar(
          onPressed: () {},
          prefixIcon: Icons.menu_book_rounded,
          lable: 'Privacy Policy',
        ),
        ProfileBottonsBar(
          onPressed: () {},
          prefixIcon: Icons.menu_book_rounded,
          lable: 'Open Source Licenses',
        ),
        LogOutWidget(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppConstants.homeScreen,
              (route) => false,
            );
          },
        ),
        const Text(
          'Version 1.0.0',
        ),
      ],
    );
  }
}
