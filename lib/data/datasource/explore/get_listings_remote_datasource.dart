import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetListingsRemoteDatasource {
  Future<List<Map<String, dynamic>>> getListings();
}

class GetListingsRemoteDatasourceImp implements GetListingsRemoteDatasource {
  final FirebaseFirestore firestore;

  GetListingsRemoteDatasourceImp({required this.firestore});

  @override
  Future<List<Map<String, dynamic>>> getListings() async {
    try {
      CollectionReference listingsRef = firestore.collection('listings');
      QuerySnapshot querySnapshot =
          await listingsRef.where('approved', isEqualTo: true).get();

      // Map Firestore documents to a list of Maps
      List<Map<String, dynamic>> listings = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return listings;
    } catch (e) {
      print('Error fetching approved listings: $e');
      return [];
    }
  }
}
