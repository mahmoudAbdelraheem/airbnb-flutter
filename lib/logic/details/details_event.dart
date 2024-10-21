part of 'details_bloc.dart';

@immutable
sealed class DetailsEvent {}

class GetHostAndReviewsDetailsEvent extends DetailsEvent {
  final String hostId;

  GetHostAndReviewsDetailsEvent({required this.hostId});
}
