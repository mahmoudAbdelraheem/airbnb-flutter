part of 'reservation_bloc.dart';

@immutable
sealed class ReservationState {}

final class ReservationInitialState extends ReservationState {}

final class ReservationLoadingState extends ReservationState {}

final class ReservationErrorState extends ReservationState {
  final String message;
  ReservationErrorState({
    required this.message,
  });
}

final class GetReservationsSuccessState extends ReservationState {
  final List<ReservationModel> reservations;
  GetReservationsSuccessState({
    required this.reservations,
  });
}
