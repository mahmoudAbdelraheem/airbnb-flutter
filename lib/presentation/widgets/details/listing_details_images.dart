import '../../../data/models/listing_model.dart';
import 'listing_details_header.dart';
import '../listing_images_view.dart';
import 'package:flutter/material.dart';

class ListingDetailsImages extends StatefulWidget {
  final ListingModel listing;
  final bool isFavorite;
  const ListingDetailsImages(
      {super.key, required this.listing, required this.isFavorite});

  @override
  State<ListingDetailsImages> createState() => _ListingDetailsImagesState();
}

class _ListingDetailsImagesState extends State<ListingDetailsImages> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: ListingImagesView(
            imagesUrl: widget.listing.imageSrc,
            onImageChanged: (index) {
              setState(() {
                currentIndex = index + 1;
              });
            },
          ),
        ),
        ListingDetailsHeader(
          isFavorite: widget.isFavorite,
          listingId: widget.listing.id,
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black54.withOpacity(0.7),
            ),
            child: Text(
              "$currentIndex / ${widget.listing.imageSrc.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
