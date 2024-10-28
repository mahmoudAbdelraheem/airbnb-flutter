import 'package:flutter/material.dart';

import '../../../core/widgets/custom_button.dart';

class BottomActions extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onSearch;

  const BottomActions({
    super.key,
    required this.onClear,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onClear,
            child: const Text(
              'Clear all',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                color: Colors.black,
              ),
            ),
          ),
          CustomButton(
            text: 'Search',
            width: 100,
            onTap: onSearch,
          ),
        ],
      ),
    );
  }
}
