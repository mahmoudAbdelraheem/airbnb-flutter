import 'package:airbnb_flutter/data/datasource/search/search_remote_datesource.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';

abstract class SearchRepository {
  Future<List<ListingModel>> getSearchResults({
    required String locationValue,
    required int guestCount,
    required int roomCount,
    required int bathroomCount,
    required DateTime startDate,
    required DateTime endDate,
  });
}

class SearchRepositoryImp implements SearchRepository {
  final SearchRemoteDatesource searchRemoteDatesource;

  SearchRepositoryImp({required this.searchRemoteDatesource});
  @override
  Future<List<ListingModel>> getSearchResults({
    required String locationValue,
    required int guestCount,
    required int roomCount,
    required int bathroomCount,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final listings = await searchRemoteDatesource.getSearchResults(
        locationValue: locationValue,
        guestCount: guestCount,
        roomCount: roomCount,
        bathroomCount: bathroomCount,
        startDate: startDate,
        endDate: endDate,
      );
      return listings.map((listing) => ListingModel.fromJson(listing)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
