import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListingLoading extends StatelessWidget {
  const ListingLoading({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Color baseColor = const Color.fromARGB(255, 194, 184, 184);
    Color highlightColor = Colors.grey[300]!;
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      itemCount: 2,
      separatorBuilder: (_, index) => const SizedBox(height: 20),
      itemBuilder: (_, index) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
