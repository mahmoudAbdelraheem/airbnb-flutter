import 'package:airbnb_flutter/core/classes/time_ago.dart';
import 'package:airbnb_flutter/data/models/review_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    DateTime createdDate = DateTime.parse(review.createdAt);

    String timeAgo = TimeAgo.format(createdDate);
    return Container(
      width: screenSize.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              StarRating(
                mainAxisAlignment: MainAxisAlignment.start,
                rating: review.rate,
                size: 18,
                color: Colors.black,
                emptyIcon: Icons.star_outline_rounded,
                filledIcon: Icons.star_rounded,
                halfFilledIcon: Icons.star_half_rounded,
              ),
              const SizedBox(width: 10),
              Text(timeAgo)
            ],
          ),
          const SizedBox(height: 15),
          Text(
            review.content,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 4,
          ),
          const Spacer(),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    CachedNetworkImageProvider(review.reviewerImage),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 10),
              Text(review.reviewerName),
            ],
          ),
        ],
      ),
    );
  }
}
