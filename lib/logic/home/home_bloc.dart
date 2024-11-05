import 'dart:async';

import '../../data/models/user_model.dart';
import '../../data/repositories/home/user_data_repository.dart';
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
    on<HomeLogoutEvent>(_logout);
    on<SaveUserDataEvent>(_saveUserData);
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
      if (user != null) {
        userModel = await userDataRepository.getUserDataById(user!.uid);

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

  FutureOr<void> _logout(HomeLogoutEvent event, Emitter<HomeState> emit) async {
    try {
      bool result = await userDataRepository.logout();
      if (result) {
        emit(HomeLogoutSuccessState());
      } else {
        emit(HomeErrorState(error: 'error'));
      }
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _saveUserData(
    SaveUserDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoadingState());
      bool result = await userDataRepository.saveUserData(
          event.userModel.id, event.userModel);
      if (result) {
        emit(HomeUserDataSaveSuccessState());
      } else {
        emit(HomeErrorState(error: 'something went wrong please try agin.'));
      }
    } catch (e) {
      emit(HomeErrorState(error: 'something went wrong please try agin.'));
    }
  }
}
