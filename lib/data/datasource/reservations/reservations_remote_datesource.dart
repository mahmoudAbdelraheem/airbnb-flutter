import 'package:airbnb_flutter/data/models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ReservationsRemoteDatesource {
  Future<List<Map<String, dynamic>>> getReservationsByListingId(String id);
  Future<bool> addNewReservation(ReservationModel reservation);
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
      print('Error adding reservation: $e');
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
      print('Error getting reservations by listingId: $e');
      return [];
    }
  }
}
