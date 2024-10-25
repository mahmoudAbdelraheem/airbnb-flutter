part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitialState extends FavoriteState {}

final class FavoriteLoadingState extends FavoriteState {}

final class FavoriteErrorState extends FavoriteState {
  final String error;
  FavoriteErrorState({
    required this.error,
  });
}

final class AddRemoveFavoriteSuccessState extends FavoriteState {
  final List<String> favoriteIds;

  AddRemoveFavoriteSuccessState({required this.favoriteIds});
}

final class GetFavoritesSuccessState extends FavoriteState {
  final List<ListingModel> favoriteListings;
  final List<String> favoriteIds;

  GetFavoritesSuccessState({
    required this.favoriteListings,
    required this.favoriteIds,
  });
}
