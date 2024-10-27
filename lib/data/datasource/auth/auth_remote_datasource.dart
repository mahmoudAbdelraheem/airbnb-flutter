import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDatasource {
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<User> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<User> signInWithGoogle();
  Future<User> signInWithGithub();
}

class AuthRemoteDatasourceImp implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDatasourceImp({
    required this.firebaseAuth,
    required this.firestore,
  });

  Future<void> _saveUserToFirestore(User user) async {
    final userDoc = firestore.collection('users').doc(user.uid);

    final userSnapshot = await userDoc.get();

    List<String> favoritesIds = [];

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      favoritesIds = List<String>.from(userData['favoritesIds'] ?? []);
    }

    await userDoc.set({
      'id': user.uid,
      'name': user.displayName,
      'email': user.email,
      'image': user.photoURL,
      'favoritesIds': favoritesIds,
    }, SetOptions(merge: true));
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    late User user;
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user!.updateDisplayName(name);

      user = credential.user!;

      await _saveUserToFirestore(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception(e.message!);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return user;
  }

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    late User user;
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = credential.user!;

      await _saveUserToFirestore(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception(e.message!);
      }
    }
    return user;
  }

  @override
  Future<User> signInWithGoogle() async {
    late User user;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception('Google sign in aborted');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      user = userCredential.user!;

      await _saveUserToFirestore(user);
    } catch (e) {
      throw Exception(e.toString());
    }
    return user;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<User> signInWithGithub() async {
    // TODO: Implement Github sign-in with Firestore user data saving
    throw UnimplementedError();
  }
}
