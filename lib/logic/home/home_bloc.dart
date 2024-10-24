import 'dart:async';

import 'package:airbnb_flutter/data/models/user_model.dart';
import 'package:airbnb_flutter/data/repositories/home/favorite_repository.dart';
import 'package:airbnb_flutter/data/repositories/home/user_data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserDataRepository userDataRepository;
  final FavoriteRepository favoriteRepository;
  HomeBloc({
    required this.userDataRepository,
    required this.favoriteRepository,
  }) : super(HomeInitialState()) {
    on<HomeGetCurrentUserEvent>(_getCurrentUser);
    on<HomeAddFavoriteEvent>(_addFavorite);
    on<HomeRemoveFavoriteEvent>(_removeFavorite);
  }
  User? user;
  UserModel? userModel;
  FutureOr<void> _getCurrentUser(
    HomeGetCurrentUserEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoadingState());
      user = await userDataRepository.checkCurrentUserStatus();
      print("===========================================");
      print("user is $user");
      print("===========================================");
      if (user != null) {
        userModel = await userDataRepository.getUserDataById(user!.uid);

        print("===========================================");
        print("user model is ${userModel!.favoriteIds}");
        print("user model is ${userModel!.email}");
        print("===========================================");
        emit(HomeCurrentUserState(user: user, userModel: userModel));
      }
      emit(HomeCurrentUserState(user: user));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _addFavorite(
    HomeAddFavoriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final bool result = await favoriteRepository.addToFavorites(
        event.listingId,
        user!.uid,
      );
      if (result == true) {
        // userModel!.favoriteIds.add(event.listingId);
        emit(HomeAddFavoriteState());
      } else {
        emit(HomeErrorState(error: "Something went wrong"));
      }
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _removeFavorite(
    HomeRemoveFavoriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final bool result = await favoriteRepository.removeFromFavorites(
        event.listingId,
        user!.uid,
      );
      if (result == true) {
        // userModel!.favoriteIds.remove(event.listingId);

        emit(HomeRemoveFavoriteState());
      } else {
        emit(HomeErrorState(error: "Something went wrong"));
      }
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }
}
