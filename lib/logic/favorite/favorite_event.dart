part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {
  final String listingId;
  final String userId;
  AddFavoriteEvent({
    required this.listingId,
    required this.userId,
  });
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final String listingId;
  final String userId;
  RemoveFavoriteEvent({
    required this.listingId,
    required this.userId,
  });
}

class GetFavoritesEvent extends FavoriteEvent {
  final String? userId;
  GetFavoritesEvent({
    required this.userId,
  });
}
