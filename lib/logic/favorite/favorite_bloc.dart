import 'dart:async';

import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/data/repositories/favorites/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;
  FavoriteBloc({
    required this.favoriteRepository,
  }) : super(FavoriteInitialState()) {
    on<GetFavoritesEvent>(_getFavoritesLitings);
    on<AddFavoriteEvent>(_addToFavorites);
    on<RemoveFavoriteEvent>(_removeFromFavorites);
  }
  List<ListingModel> favorites = [];
  List<String> favoritesIds = [];
  FutureOr<void> _getFavoritesLitings(
    GetFavoritesEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      emit(FavoriteLoadingState());

      favorites = await favoriteRepository.getFavoritesByUserId(event.userId!);
      favoritesIds = favorites.map((listing) => listing.id).toList();
      emit(
        GetFavoritesSuccessState(
          favoriteListings: favorites,
          favoriteIds: favoritesIds,
        ),
      );
    } catch (e) {
      emit(
        FavoriteErrorState(
          error: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _addToFavorites(
    AddFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final bool result = await favoriteRepository.addToFavorites(
        event.listingId,
        event.userId,
      );
      if (result == true) {
        favoritesIds.add(event.listingId);
        emit(AddRemoveFavoriteSuccessState(favoriteIds: favoritesIds));
      } else {
        emit(FavoriteErrorState(error: "Something went wrong"));
      }
    } catch (e) {
      emit(FavoriteErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _removeFromFavorites(
    RemoveFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      final bool result = await favoriteRepository.removeFromFavorites(
        event.listingId,
        event.userId,
      );
      if (result == true) {
        favoritesIds.remove(event.listingId);

        emit(AddRemoveFavoriteSuccessState(favoriteIds: favoritesIds));
      } else {
        emit(FavoriteErrorState(error: "Something went wrong"));
      }
    } catch (e) {
      emit(FavoriteErrorState(error: e.toString()));
    }
  }
}
