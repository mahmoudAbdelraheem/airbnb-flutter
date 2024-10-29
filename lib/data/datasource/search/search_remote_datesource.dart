import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SearchRemoteDatesource {
  Future<List<Map<String, dynamic>>> getSearchResults({
    required String locationValue,
    required int guestCount,
    required int roomCount,
    required int bathroomCount,
    required DateTime startDate,
    required DateTime endDate,
  });
}

class SearchRemoteDatesourceImp implements SearchRemoteDatesource {
  final FirebaseFirestore firestore;

  SearchRemoteDatesourceImp({required this.firestore});

  @override
  Future<List<Map<String, dynamic>>> getSearchResults({
    required String locationValue,
    required int guestCount,
    required int roomCount,
    required int bathroomCount,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final startTimestamp = Timestamp.fromDate(startDate);
    final endTimestamp = Timestamp.fromDate(endDate);

    try {
      // Step 1: Query reservations that overlap with the selected date range
      final reservationQuery = FirebaseFirestore.instance
          .collection('reservations')
          .where('startDate', isLessThanOrEqualTo: endTimestamp)
          .where('endDate', isGreaterThanOrEqualTo: startTimestamp);

      final reservationSnapshot = await reservationQuery.get();
      final reservedListingIds =
          reservationSnapshot.docs.map((doc) => doc['listingId']).toList();

      // Step 2: Query listings that match the selected criteria
      Query listingsQuery = FirebaseFirestore.instance.collection('listings');
      if (locationValue.isNotEmpty) {
        listingsQuery =
            listingsQuery.where('locationValue', isEqualTo: locationValue);
      }
      if (guestCount > 0) {
        listingsQuery = listingsQuery.where('guestCount',
            isGreaterThanOrEqualTo: guestCount);
      }
      if (roomCount > 0) {
        listingsQuery =
            listingsQuery.where('roomCount', isGreaterThanOrEqualTo: roomCount);
      }
      if (bathroomCount > 0) {
        listingsQuery = listingsQuery.where('bathroomCount',
            isGreaterThanOrEqualTo: bathroomCount);
      }

      final listingsSnapshot = await listingsQuery.get();

      // Filter listings to exclude those with overlapping reservations
      final availableListings = listingsSnapshot.docs
          .where((doc) => !reservedListingIds.contains(doc.id))
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();

      print("Available listings: $availableListings");
      return availableListings;
    } catch (error) {
      throw Exception("Error fetching available listings: $error");
    }
  }
}
