import 'package:flutter/material.dart';

Future<dynamic> showBottomSheetModal({
  required BuildContext context,
  required Size screenSize,
  required Widget child,
  bool isScrollControlled = true,
  bool isRounded = true,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: isRounded
        ? const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          )
        : null,
    builder: (context) => Container(
      height: screenSize.height * 0.95,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: child,
    ),
  );
}
