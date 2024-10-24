// data/repositories/get_listings_repository_impl.dart
import 'package:airbnb_flutter/data/datasource/explore/get_listings_remote_datasource.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';

abstract class GetListingsRepository {
  Future<List<ListingModel>> getListings();
}

class GetListingsRepositoryImp implements GetListingsRepository {
  final GetListingsRemoteDatasource remoteDatasource;

  GetListingsRepositoryImp({required this.remoteDatasource});

  @override
  Future<List<ListingModel>> getListings() async {
    try {
      // Fetch the raw data from the data source
      List<Map<String, dynamic>> listingsData =
          await remoteDatasource.getListings();
      // Convert each Map<String, dynamic> into a ListingModel
      List<ListingModel> listings = listingsData.map((data) {
        return ListingModel.fromJson(data);
      }).toList();

      return listings;
    } catch (e) {
      print('Error fetching and converting listings: $e');
      return [];
    }
  }
}
