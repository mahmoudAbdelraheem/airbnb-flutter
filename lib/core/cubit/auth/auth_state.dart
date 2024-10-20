part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoggedIn extends AuthState {
  final User user;

  AuthLoggedIn({required this.user});
}

class AuthLoggedOut extends AuthState {}
