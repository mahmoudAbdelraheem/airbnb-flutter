import 'package:airbnb_flutter/data/datasource/reservations/reservations_remote_datesource.dart';
import 'package:airbnb_flutter/data/models/reservation_model.dart';

abstract class ReservationsRepository {
  Future<List<ReservationModel>> getReservationsByListingId(String id);
  Future<bool> addNewReservation(ReservationModel reservation);
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
    print('reservations list modles = ${reservations[0].startDate}');
    return reservations;
  }

  @override
  Future<bool> addNewReservation(
    ReservationModel reservation,
  ) async {
    return await reservationsRemoteDatesource.addNewReservation(reservation);
  }
}
