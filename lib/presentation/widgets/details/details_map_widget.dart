import '../../../core/constants/app_constants.dart';
import 'listing_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class DetailsMapWidget extends StatelessWidget {
  final List<String> listingLocation;
  const DetailsMapWidget({
    super.key,
    required this.listingLocation,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppConstants.fullMapScreen,
          arguments: listingLocation,
        );
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AbsorbPointer(
                  child: ListingMap(
                    flat: false,
                    currentLocation: LatLng(
                      double.parse(listingLocation[0]),
                      double.parse(
                        listingLocation[1],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadowColor: Colors.black54,
                elevation: 10,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Exact Location provided after booking.',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
