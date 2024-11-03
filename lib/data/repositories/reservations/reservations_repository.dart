import 'package:airbnb_flutter/data/datasource/reservations/reservations_remote_datesource.dart';
import 'package:airbnb_flutter/data/models/reservation_model.dart';

abstract class ReservationsRepository {
  Future<List<ReservationModel>> getReservationsByListingId(String id);
  Future<List<ReservationModel>> getReservationsByUserId(String id);
  Future<bool> addNewReservation(ReservationModel reservation);
  Future<bool> cancleReservation(String reservationId);
}

class ReservationsRepositoryImp implements ReservationsRepository {
  final ReservationsRemoteDatesource reservationsRemoteDatesource;

  ReservationsRepositoryImp({required this.reservationsRemoteDatesource});

  @override
  Future<List<ReservationModel>> getReservationsByListingId(
    String id,
  ) async {
    final reservationsData =
        await reservationsRemoteDatesource.getReservationsByListingId(id);
    print('reservations data for this listing is = $reservationsData');

    List<ReservationModel> reservations = [];
    reservations = reservationsData
        .map(
          (reservation) => ReservationModel.fromJson(reservation),
        )
        .toList();
    return reservations;
  }

  @override
  Future<List<ReservationModel>> getReservationsByUserId(
    String id,
  ) async {
    final reservationsData =
        await reservationsRemoteDatesource.getReservationsByUserId(id);
    print('reservations data for this user is = $reservationsData');

    List<ReservationModel> reservations = [];
    reservations = reservationsData
        .map(
          (reservation) => ReservationModel.fromJson(reservation),
        )
        .toList();
    return reservations;
  }

  @override
  Future<bool> addNewReservation(
    ReservationModel reservation,
  ) async {
    return await reservationsRemoteDatesource.addNewReservation(reservation);
  }

  @override
  Future<bool> cancleReservation(String reservationId) async {
    return await reservationsRemoteDatesource.cancleReservation(reservationId);
  }
}
