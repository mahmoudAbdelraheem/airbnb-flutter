import 'dart:async';

import 'package:airbnb_flutter/data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({
    required this.authRepository,
  }) : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) => emit(AuthLoadingState()));
    on<AuthLoginEvent>(_login);
    on<AuthSignUpEvent>(_signUp);
    on<AuthLoginGoogleEvent>(_loginWithGoogle);
  }

  FutureOr<void> _login(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final User = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      print("======loggedin======current user data is $User");
      emit(AuthLoggedInState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _signUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final User = await authRepository.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      );
      print("======signup======current user data is $User");
      emit(AuthSignedUpState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _loginWithGoogle(
    AuthLoginGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final User = await authRepository.signInWithGoogle();
      print("======google======current user data is $User");
      emit(AuthLoggedInState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
