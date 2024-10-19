import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListingImagesView extends StatefulWidget {
  final List<String> imagesUrl;
  final Function(int) onImageChanged;

  const ListingImagesView({
    super.key,
    required this.imagesUrl,
    required this.onImageChanged,
  });

  @override
  State<ListingImagesView> createState() => _ListingImagesViewState();
}

class _ListingImagesViewState extends State<ListingImagesView> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      onPageChanged: widget.onImageChanged,
      itemCount: widget.imagesUrl.length,
      itemBuilder: (_, pageIndex) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                widget.imagesUrl[pageIndex],
              ),
              fit: BoxFit.cover, // Fit the image properly
            ),
          ),
        );
      },
    );
  }
}
