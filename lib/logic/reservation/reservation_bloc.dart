import 'dart:async';

import 'package:airbnb_flutter/data/models/reservation_model.dart';
import 'package:airbnb_flutter/data/repositories/reservations/reservations_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationsRepository reservationsRepository;
  ReservationBloc({
    required this.reservationsRepository,
  }) : super(ReservationInitialState()) {
    on<GetReservationsEvent>(_getReservationsByListingId);
  }
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  double totalPrice = 0.0;
  String userId = '';
  String authorId = '';
  String listingId = '';
  FutureOr<void> _getReservationsByListingId(
    GetReservationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      emit(ReservationLoadingState());

      List<ReservationModel> reservations = await reservationsRepository
          .getReservationsByListingId(event.listingId);

      emit(
        GetReservationsSuccessState(
          reservations: reservations,
        ),
      );
    } catch (e) {
      emit(ReservationErrorState(message: e.toString()));
    }
  }
}
