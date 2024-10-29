part of 'explore_bloc.dart';

@immutable
sealed class ExploreEvent {}

class GetListingsAndCategoriesEvent extends ExploreEvent {}

class OnListingsSearchEvent extends ExploreEvent {
  final String locationValue;
  final String category;
  final int guestCount;
  final int roomCount;
  final int bathroomCount;
  final DateTime startDate;
  final DateTime endDate;

  OnListingsSearchEvent({
    required this.locationValue,
    required this.category,
    required this.guestCount,
    required this.roomCount,
    required this.bathroomCount,
    required this.startDate,
    required this.endDate,
  });
}
