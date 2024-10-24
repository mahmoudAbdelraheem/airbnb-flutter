import 'dart:async';

import 'package:airbnb_flutter/data/models/category_model.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/data/repositories/explore/get_categories_repository.dart';
import 'package:airbnb_flutter/data/repositories/explore/get_listing_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetListingsRepository listingsRepository;
  final GetCategotiesRepository categoriesRepository;
  ExploreBloc({
    required this.listingsRepository,
    required this.categoriesRepository,
  }) : super(ExploreInitialState()) {
    on<GetListingsAndCategoriesEvent>(_getListingsAndCategories);
  }

  FutureOr<void> _getListingsAndCategories(
    GetListingsAndCategoriesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      emit(GetListingsAndCategoriesLoadingState());
      List<ListingModel> listings = await listingsRepository.getListings();
      List<CategoryModel> categories =
          await categoriesRepository.getCategories();
      emit(
        GetListingsAndCategoriesSuccessState(
          listings: listings,
          categories: categories,
        ),
      );
    } catch (e) {
      emit(GetListingsAndCategoriesErrorState(error: e.toString()));
    }
  }
}
