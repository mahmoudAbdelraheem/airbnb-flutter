import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ReserveWidget extends StatelessWidget {
  final ListingModel listing;
  const ReserveWidget({
    super.key,
    required this.listing,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM - dd').format(now);
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '\$${listing.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const TextSpan(
                      text: '  night',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  height: 1.2,
                ),
              ),
            ],
          ),
          CustomButton(
            text: 'Reserve',
            width: 150,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
