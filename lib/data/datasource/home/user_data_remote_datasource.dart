import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDataRemoteDatasource {
  Future<Map<String, dynamic>> getUserDataById(String id);
  Future<User?> checkCurrentUserStatus();
}

class UserDataRemoteDatasourceImp implements UserDataRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  const UserDataRemoteDatasourceImp({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<User?> checkCurrentUserStatus() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        // User is logged in
        return user;
      } else {
        // User is not logged out
        return null;
      }
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
