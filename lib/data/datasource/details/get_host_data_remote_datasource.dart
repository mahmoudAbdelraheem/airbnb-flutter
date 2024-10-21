import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetHostDataRemoteDatasource {
  Future<Map<String, dynamic>> getHostDataById(String id);
  Future<List<Map<String, dynamic>>> getReviewsByHostId(String id);
}

class GetHostDataRemoteDatasourceImp implements GetHostDataRemoteDatasource {
  final FirebaseFirestore firestore;

  GetHostDataRemoteDatasourceImp({required this.firestore});

  @override
  Future<Map<String, dynamic>> getHostDataById(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('users').doc(id).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        throw Exception("Host with ID $id not found");
      }
    } catch (e) {
      throw Exception("Error fetching host data: $e");
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getReviewsByHostId(String id) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('reviews')
          .where('hostId', isEqualTo: id)
          .get();

      List<Map<String, dynamic>> reviews = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return reviews;
    } catch (e) {
      throw Exception("Error fetching reviews for host: $e");
    }
  }
}
