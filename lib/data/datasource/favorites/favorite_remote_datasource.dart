import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FavoriteRemoteDatasource {
  Future<bool> removeFromFavorites(String id, String userId);
  Future<bool> addToFavorites(String id, String userId);
  Future<List<Map<String, dynamic>>> getFavoritesByUserId(String userId);
  Future<Map<String, dynamic>> getUserDataById(String id);
}

class FavoriteRemoteDatasourceImp implements FavoriteRemoteDatasource {
  final FirebaseFirestore firestore;
  FavoriteRemoteDatasourceImp({required this.firestore});

  @override
  Future<bool> addToFavorites(String id, String userId) async {
    try {
      await firestore.collection('users').doc(userId).update({
        'favoritesIds': FieldValue.arrayUnion([id])
      });

      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> removeFromFavorites(String id, String userId) async {
    try {
      await firestore.collection('users').doc(userId).update({
        'favoritesIds': FieldValue.arrayRemove([id])
      });

      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getFavoritesByUserId(
    String userId,
  ) async {
    try {
      // Step 1: Retrieve the user document to get favoritesIds
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception("User not found");
      }

      // Get the favoritesIds from the user document
      List<dynamic> favoriteIds = userDoc['favoritesIds'] ?? [];

      if (favoriteIds.isEmpty) {
        return []; // Return an empty list if there are no favorite IDs
      }

      // Step 2: Fetch listings based on favoriteIds
      QuerySnapshot listingSnapshot = await firestore
          .collection('listings')
          .where(FieldPath.documentId, whereIn: favoriteIds)
          .get();

      // Map listing documents to a list of maps
      List<Map<String, dynamic>> listings = listingSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return listings;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getUserDataById(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('users').doc(id).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        throw Exception("User with ID $id not found");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
