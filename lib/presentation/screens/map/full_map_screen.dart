import 'package:airbnb_flutter/core/widgets/my_icon.dart';
import 'package:airbnb_flutter/presentation/widgets/details/listing_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class FullMapScreen extends StatelessWidget {
  final List<String> listingLocation;
  const FullMapScreen({
    super.key,
    required this.listingLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListingMap(
            flat: true,
            currentLocation: LatLng(
              double.parse(listingLocation[0]),
              double.parse(listingLocation[1]),
            ),
          ),
          Positioned(
            top: 45,
            left: 15,
            child: MyIcon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icons.arrow_back,
            ),
          ),
        ],
      ),
    );
  }
}
