import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/presentation/widgets/listing_images_view.dart';
import 'package:flutter/material.dart';

class ListingCard extends StatefulWidget {
  final ListingModel listing;
  const ListingCard({
    super.key,
    required this.listing,
  });

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppConstants.detailsScreen,
          arguments: widget.listing,
        );
      },
      child: Container(
        decoration: const BoxDecoration(),
        padding:
            const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListingImagesView(
                        imagesUrl: widget.listing.imageSrc,
                        onImageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            // Icons.favorite,
                            // color: Colors.pink[500],
                            size: 26,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            widget.listing.imageSrc.length,
                            (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(
                                  right: 10,
                                  bottom: 15,
                                ),
                                height: currentIndex == index ? 10 : 8,
                                width: currentIndex == index ? 10 : 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? Colors.white
                                      : Colors.grey[600],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              widget.listing.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              widget.listing.location,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${widget.listing.price}\$ ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const TextSpan(
                    text: "per night",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
