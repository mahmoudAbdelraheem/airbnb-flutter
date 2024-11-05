import '../../../data/models/review_model.dart';
import 'review_widget.dart';
import 'package:flutter/material.dart';

class HostReviews extends StatelessWidget {
  final List<ReviewModel> reviews;
  const HostReviews({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        height: 220,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ReviewWidget(review: reviews[index]);
            }),
      ),
    );
  }
}
