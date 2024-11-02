part of 'reservation_bloc.dart';

@immutable
sealed class ReservationEvent {}

class GetReservationsEvent extends ReservationEvent {
  final String listingId;

  GetReservationsEvent({required this.listingId});
}

class AddReservationEvent extends ReservationEvent {
  final ReservationModel reservation;
  AddReservationEvent({required this.reservation});
}
