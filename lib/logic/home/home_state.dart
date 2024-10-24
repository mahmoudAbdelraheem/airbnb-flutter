part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeCurrentUserState extends HomeState {
  final User? user;
  final UserModel? userModel;
  HomeCurrentUserState({this.user, this.userModel});
}

final class HomeAddFavoriteState extends HomeState {}

final class HomeRemoveFavoriteState extends HomeState {}

final class HomeLoggedOutState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState({required this.error});
}
