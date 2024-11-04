import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDataRemoteDatasource {
  Future<Map<String, dynamic>> getUserDataById(String id);
  Future<User?> checkCurrentUserStatus();
  Future<bool> logout();
  Future<bool> saveUserData(
    String id,
    Map<String, dynamic> userData,
  );
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
      return user;
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

  @override
  Future<bool> logout() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  // New method to save or update user data
  @override
  Future<bool> saveUserData(String id, Map<String, dynamic> userData) async {
    try {
      await firestore
          .collection('users')
          .doc(id)
          .set(userData, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }
}
