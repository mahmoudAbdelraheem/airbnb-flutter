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

final class HomeLogoutSuccessState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState({required this.error});
}

final class HomeUserDataSaveSuccessState extends HomeState {}

final class HomeOnPageChangedState extends HomeState {
  final int pageIndex;
  HomeOnPageChangedState({required this.pageIndex});
}
