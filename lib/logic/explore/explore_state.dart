part of 'explore_bloc.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitialState extends ExploreState {}

final class GetListingsAndCategoriesSuccessState extends ExploreState {
  final List<ListingModel> listings;
  final List<CategoryModel> categories;

  GetListingsAndCategoriesSuccessState({
    required this.listings,
    required this.categories,
  });
}

final class GetListingsAndCategoriesErrorState extends ExploreState {
  final String error;
  GetListingsAndCategoriesErrorState({required this.error});
}

final class GetListingsAndCategoriesLoadingState extends ExploreState {}
