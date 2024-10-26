import 'dart:async';

import 'package:airbnb_flutter/data/models/user_model.dart';
import 'package:airbnb_flutter/data/repositories/home/user_data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserDataRepository userDataRepository;
  HomeBloc({
    required this.userDataRepository,
  }) : super(HomeInitialState()) {
    on<HomeGetCurrentUserEvent>(_getCurrentUser);
    on<HomeOnPageChangedEvent>(_onPageChanged);
  }
  User? user;
  UserModel? userModel;
  int currentPageIndex = 0;
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

  FutureOr<void> _onPageChanged(
    HomeOnPageChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    currentPageIndex = event.index;
    emit(HomeOnPageChangedState(pageIndex: currentPageIndex));
  }
}
