import 'dart:async';

import '../../data/models/reservation_model.dart';
import '../../data/repositories/reservations/reservations_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationsRepository reservationsRepository;
  ReservationBloc({
    required this.reservationsRepository,
  }) : super(ReservationInitialState()) {
    on<GetReservationsByListingIdEvent>(_getReservationsByListingId);
    on<GetReservationsByUserIdEvent>(_getReservationsByUserId);
    on<AddReservationEvent>(_addNewReservation);
    on<CancelReservationEvent>(_cancelReservation);
  }
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  double totalPrice = 0.0;
  String userId = '';
  String authorId = '';
  String listingId = '';

  List<ReservationModel> reservations = [];
  FutureOr<void> _getReservationsByListingId(
    GetReservationsByListingIdEvent event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      emit(ReservationLoadingState());

      reservations = await reservationsRepository
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

  FutureOr<void> _addNewReservation(
    AddReservationEvent event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      emit(ReservationLoadingState());

      bool result = await reservationsRepository.addNewReservation(
        event.reservation,
      );
      if (result) {
        add(
          GetReservationsByListingIdEvent(
              listingId: event.reservation.listingId),
        );
      } else {
        emit(
          ReservationErrorState(
            message: "Something went wrong",
          ),
        );
      }
    } catch (e) {
      emit(ReservationErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _getReservationsByUserId(
    GetReservationsByUserIdEvent event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      emit(ReservationLoadingState());
      List<ReservationModel> reservations =
          await reservationsRepository.getReservationsByUserId(event.userId);
      emit(
        GetReservationsSuccessState(
          reservations: reservations,
        ),
      );
    } catch (e) {
      emit(ReservationErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _cancelReservation(
    CancelReservationEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(ReservationLoadingState());
    try {
      bool result = await reservationsRepository.cancleReservation(
        event.reservationId,
      );

      if (result) {
        add(
          GetReservationsByUserIdEvent(
            userId: event.userId,
          ),
        );
      } else {
        emit(ReservationErrorState(message: "Something went wrong"));
      }
    } catch (e) {
      emit(ReservationErrorState(message: e.toString()));
    }
  }
}
