import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ListingMap extends StatelessWidget {
  final LatLng currentLocation;
  final bool flat; // Control interaction through this flag

  const ListingMap({
    super.key,
    required this.currentLocation,
    required this.flat, // Add flat to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
              initialCenter: currentLocation,
              initialZoom: 9.0,
              interactionOptions: InteractionOptions(
                flags: flat ? InteractiveFlag.all : InteractiveFlag.none,
              )),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 30.0,
                  height: 30.0,
                  point: currentLocation,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.pink[500],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
