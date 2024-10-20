import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(AuthInitial());

  // Method to check user auth status
  Future<void> checkAuthStatus() async {
    User? user = _firebaseAuth.currentUser;

    print('==================== current user is $user ====================');
    if (user != null) {
      // User is logged in
      emit(AuthLoggedIn(user: user));
    } else {
      // User is not logged in
      emit(AuthLoggedOut());
    }
  }

  // Method to log out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    emit(AuthLoggedOut());
  }
}
