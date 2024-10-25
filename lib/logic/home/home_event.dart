part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeGetCurrentUserEvent extends HomeEvent {}

// class HomeAddFavoriteEvent extends HomeEvent {
//   final String listingId;
//   HomeAddFavoriteEvent({
//     required this.listingId,
//   });
// }

// class HomeRemoveFavoriteEvent extends HomeEvent {
//   final String listingId;
//   HomeRemoveFavoriteEvent({
//     required this.listingId,
//   });
// }
