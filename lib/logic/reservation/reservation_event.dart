part of 'reservation_bloc.dart';

@immutable
sealed class ReservationEvent {}

class GetReservationsByListingIdEvent extends ReservationEvent {
  final String listingId;

  GetReservationsByListingIdEvent({required this.listingId});
}

class GetReservationsByUserIdEvent extends ReservationEvent {
  final String userId;

  GetReservationsByUserIdEvent({required this.userId});
}

class CancelReservationEvent extends ReservationEvent {
  final String reservationId;
  final String userId;
  CancelReservationEvent({required this.userId, required this.reservationId});
}

class AddReservationEvent extends ReservationEvent {
  final ReservationModel reservation;
  AddReservationEvent({required this.reservation});
}
