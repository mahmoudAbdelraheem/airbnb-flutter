part of 'details_bloc.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitialState extends DetailsState {}

final class DetailsLoadingState extends DetailsState {}

final class DetailsLoadedState extends DetailsState {
  final UserModel host;
  final List<ReviewModel> reviews;
  final String avarageRating;

  DetailsLoadedState({
    required this.host,
    required this.reviews,
    required this.avarageRating,
  });
}

final class DetailsErrorState extends DetailsState {
  final String message;
  DetailsErrorState({required this.message});
}
