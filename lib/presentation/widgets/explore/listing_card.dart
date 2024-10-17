import 'package:airbnb_flutter/data/models/listing_model.dart';
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
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 35),
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
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: 5,
                    itemBuilder: (_, pageIndex) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.listing.imageSrc[pageIndex],
                            ),
                            fit: BoxFit.cover, // Fit the image properly
                          ),
                        ),
                      );
                    },
                  ),
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
    );
  }
}
