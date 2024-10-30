import 'dart:async';

import 'package:airbnb_flutter/data/models/category_model.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/data/models/search/search_repository.dart';
import 'package:airbnb_flutter/data/repositories/explore/get_categories_repository.dart';
import 'package:airbnb_flutter/data/repositories/explore/get_listing_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetListingsRepository listingsRepository;
  final GetCategotiesRepository categoriesRepository;
  final SearchRepository searchRepository;
  ExploreBloc({
    required this.listingsRepository,
    required this.categoriesRepository,
    required this.searchRepository,
  }) : super(ExploreInitialState()) {
    on<GetListingsAndCategoriesEvent>(_getListingsAndCategories);
    on<OnListingsSearchEvent>(_getListingBySearchQuery);
    on<GetListingByCategoryEvent>(_getListingsByCategoryId);
  }
  String placeValue = 'Any where';
  String dateValue = 'Any week';
  String guestValue = 'Add guests';
  List<CategoryModel> categories = [];
  List<ListingModel> listings = [];

  FutureOr<void> _getListingsAndCategories(
    GetListingsAndCategoriesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      emit(GetListingsAndCategoriesLoadingState());

      listings = await listingsRepository.getListings();

      categories = await categoriesRepository.getCategories();
      emit(
        GetListingsAndCategoriesSuccessState(
          listings: listings,
          categories: categories,
        ),
      );
      placeValue = 'Any where';
      dateValue = 'Any week';
      guestValue = 'Add guests';
    } catch (e) {
      emit(GetListingsAndCategoriesErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _getListingBySearchQuery(
    OnListingsSearchEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      emit(GetListingsAndCategoriesLoadingState());
      List<ListingModel> searchListings =
          await searchRepository.getSearchResults(
        locationValue: event.locationValue,
        guestCount: event.guestCount,
        roomCount: event.roomCount,
        bathroomCount: event.bathroomCount,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      placeValue = event.category;
      dateValue =
          '${DateFormat('MMM - dd').format(event.startDate)} to ${DateFormat('MMM - dd').format(event.endDate)}';
      guestValue = '${event.guestCount} guests';
      emit(
        GetListingsAndCategoriesSuccessState(
          listings: searchListings,
          categories: categories,
          isSearch: true,
        ),
      );
    } catch (e) {
      emit(GetListingsAndCategoriesErrorState(error: e.toString()));
    }
  }

  FutureOr<void> _getListingsByCategoryId(
    GetListingByCategoryEvent event,
    Emitter<ExploreState> emit,
  ) {
    emit(GetListingsAndCategoriesLoadingState());
    List<ListingModel> categoryListings = listings
        .where((element) => element.categoryId == event.categoryId)
        .toList();
    if (categoryListings.isEmpty) {
      emit(
        GetListingsAndCategoriesSuccessState(
          listings: listings,
          categories: categories,
        ),
      );
    } else {
      emit(
        GetListingsAndCategoriesSuccessState(
          listings: categoryListings,
          categories: categories,
        ),
      );
    }
  }
}
