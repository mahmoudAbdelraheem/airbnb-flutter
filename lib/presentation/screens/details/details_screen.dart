import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/presentation/widgets/details/host_card.dart';
import 'package:airbnb_flutter/presentation/widgets/details/listing_details_images.dart';
import 'package:airbnb_flutter/presentation/widgets/details/listing_map.dart';
import 'package:airbnb_flutter/presentation/widgets/details/reserve_widget.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class DetailsScreen extends StatefulWidget {
  final ListingModel listing;
  const DetailsScreen({super.key, required this.listing});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ReserveWidget(listing: widget.listing),
      body: ListView(
        children: [
          ListingDetailsImages(listing: widget.listing),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.listing.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${widget.listing.roomCount} rooms . ${widget.listing.guestCount} guests . ${widget.listing.bathroomCount} bathrooms',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.listing.location,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.listing.category,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'About this place',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.listing.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Where you’ll be',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ListingMap(
                currentLocation: LatLng(
                  double.parse(widget.listing.mapLocation[0]),
                  double.parse(
                    widget.listing.mapLocation[1],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 1.5,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Meet Your Host',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const HostCard(),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
