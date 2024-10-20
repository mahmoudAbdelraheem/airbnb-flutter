import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor1 = Color(0xFFFF5A60); // Coral Pink (Airbnb's main)
  static const primaryColor2 = Color(0xFFFD8C73); // Lighter coral variant

  static const secondaryColor1 = Color(0xFFB1B5B6); // Light gray
  static const secondaryColor2 = Color(0xFFECECEC); // Off-white neutral

  static const whiteColor = Color(0xFFFFFFFF); // White
  static const blackColor = Color(0xFF000000); // Black
  static const grayColor = Color(0xFFB1B5B6); // Light gray (reused)
  static const lightGrayColor = Color(0xFFF7F7F7); // Soft background gray
  static const midGrayColor = Color(0xFFDEDEDE); // Mid-tone gray

  static List<Color> get primaryG => [primaryColor1, primaryColor2];
  static List<Color> get secondaryG => [secondaryColor1, secondaryColor2];
}
