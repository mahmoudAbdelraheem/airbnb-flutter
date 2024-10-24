import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FavoriteRemoteDatasource {
  Future<bool> removeFromFavorites(String id, String userId);
  Future<bool> addToFavorites(String id, String userId);
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
}
