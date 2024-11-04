part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeGetCurrentUserEvent extends HomeEvent {}

class HomeOnPageChangedEvent extends HomeEvent {
  final int index;
  HomeOnPageChangedEvent({required this.index});
}

class HomeLogoutEvent extends HomeEvent {}

class SaveUserDataEvent extends HomeEvent {
  final UserModel userModel;

  SaveUserDataEvent({required this.userModel});
}
