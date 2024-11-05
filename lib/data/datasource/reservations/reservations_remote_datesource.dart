import '../../models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ReservationsRemoteDatesource {
  Future<List<Map<String, dynamic>>> getReservationsByListingId(String id);
  Future<List<Map<String, dynamic>>> getReservationsByUserId(String id);
  Future<bool> addNewReservation(ReservationModel reservation);
  Future<bool> cancleReservation(String reservationId);
}

class ReservationsRemoteDatesourceImp implements ReservationsRemoteDatesource {
  final FirebaseFirestore firestore;

  ReservationsRemoteDatesourceImp({required this.firestore});

  @override
  Future<bool> addNewReservation(ReservationModel reservation) async {
    try {
      await firestore.collection('reservations').add(reservation.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getReservationsByListingId(
      String id) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('reservations')
          .where('listingId', isEqualTo: id)
          .get();

      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add the document ID to the map
        return data;
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getReservationsByUserId(String id) async {
    try {
      // Step 1: Fetch reservations by user ID
      QuerySnapshot reservationSnapshot = await firestore
          .collection('reservations')
          .where('userId', isEqualTo: id)
          .get();

      List<Map<String, dynamic>> reservationsWithListings = [];

      for (var reservationDoc in reservationSnapshot.docs) {
        Map<String, dynamic> reservationData =
            reservationDoc.data() as Map<String, dynamic>;
        reservationData['id'] =
            reservationDoc.id; // Add the reservation document ID

        // Step 2: Fetch the listing for each reservation's listingId
        if (reservationData.containsKey('listingId')) {
          String listingId = reservationData['listingId'];

          DocumentSnapshot listingDoc =
              await firestore.collection('listings').doc(listingId).get();
          if (listingDoc.exists) {
            Map<String, dynamic> listingData =
                listingDoc.data() as Map<String, dynamic>;
            reservationData['listingDetails'] =
                listingData; // Add listing data to reservation
          } else {
            reservationData['listingDetails'] =
                null; // Handle case if listing is not found
          }
        } else {
          reservationData['listingDetails'] =
              null; // Handle case if no listingId in reservation
        }

        reservationsWithListings.add(reservationData);
      }

      return reservationsWithListings;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> cancleReservation(String reservationId) async {
    try {
      await firestore.collection('reservations').doc(reservationId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
