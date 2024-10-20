part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeCurrentUserState extends HomeState {
  final User? user;
  HomeCurrentUserState({this.user});
}

final class HomeLoggedOutState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}
