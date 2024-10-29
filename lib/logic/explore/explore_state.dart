part of 'explore_bloc.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitialState extends ExploreState {}

final class GetListingsAndCategoriesSuccessState extends ExploreState {
  final List<ListingModel> listings;
  final List<CategoryModel> categories;
  final bool isSearch;
  GetListingsAndCategoriesSuccessState({
    required this.listings,
    required this.categories,
    this.isSearch = false,
  });
}

final class GetListingsAndCategoriesErrorState extends ExploreState {
  final String error;
  GetListingsAndCategoriesErrorState({required this.error});
}

final class GetListingsAndCategoriesLoadingState extends ExploreState {}
