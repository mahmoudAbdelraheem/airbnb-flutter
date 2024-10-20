import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseAuth firebaseAuth;
  HomeBloc({
    required this.firebaseAuth,
  }) : super(HomeInitial()) {
    on<HomeGetCurrentUserEvent>(_getCurrentUser);
  }

  FutureOr<void> _getCurrentUser(
    HomeGetCurrentUserEvent event,
    Emitter<HomeState> emit,
  ) async {
    User? user = firebaseAuth.currentUser;

    print('==================== current user is $user ====================');
    if (user != null) {
      // User is logged in
      emit(HomeCurrentUserState(user: user));
    } else {
      // User is not logged out
      emit(HomeLoggedOutState());
    }
  }
}
