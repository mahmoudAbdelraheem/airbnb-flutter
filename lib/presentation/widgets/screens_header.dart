import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ScreensHeader extends StatelessWidget {
  final String mainTitle;
  final String title;
  final String subtitle;
  final double btnWidth;
  const ScreensHeader({
    super.key,
    required this.mainTitle,
    required this.title,
    required this.subtitle,
    this.btnWidth = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainTitle,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        const SizedBox(height: 15),
        title == ''
            ? Container()
            : Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        CustomButton(
          text: 'Log in',
          onTap: () {
            Navigator.pushNamed(
              context,
              AppConstants.loginScreen,
            );
          },
          width: btnWidth,
        ),
      ],
    );
  }
}
