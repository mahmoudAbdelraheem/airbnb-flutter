part of 'explore_bloc.dart';

@immutable
sealed class ExploreEvent {}

class GetListingsAndCategoriesEvent extends ExploreEvent {}
