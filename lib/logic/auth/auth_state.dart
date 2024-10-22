part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthLoggedInState extends AuthState {}

final class AuthSignedUpState extends AuthState {}

final class AuthLoggedInWithGoogleState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
}
