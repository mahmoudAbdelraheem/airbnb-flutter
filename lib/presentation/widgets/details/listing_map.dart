import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ListingMap extends StatelessWidget {
  final LatLng currentLocation;
  // final void Function(TapPosition, LatLng)? onMapTap;
  const ListingMap({
    super.key,
    required this.currentLocation,
    // required this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: currentLocation,
            initialZoom: 5.0,
            // onTap: onMapTap,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: currentLocation,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.pink[500],
                    size: 30,
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
