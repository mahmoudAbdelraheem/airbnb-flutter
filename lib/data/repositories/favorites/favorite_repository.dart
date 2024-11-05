import '../../datasource/favorites/favorite_remote_datasource.dart';
import '../../models/listing_model.dart';
import '../../models/user_model.dart';

abstract class FavoriteRepository {
  Future<bool> removeFromFavorites(String id, String userId);
  Future<bool> addToFavorites(String id, String userId);
  Future<List<ListingModel>> getFavoritesByUserId(String userId);
  Future<UserModel> getUserDataById(String id);
}

class FavoriteRepositoryImp implements FavoriteRepository {
  final FavoriteRemoteDatasource favoriteRemoteDatasource;

  FavoriteRepositoryImp({required this.favoriteRemoteDatasource});
  @override
  Future<bool> addToFavorites(String id, String userId) {
    return favoriteRemoteDatasource.addToFavorites(id, userId);
  }

  @override
  Future<bool> removeFromFavorites(String id, String userId) {
    return favoriteRemoteDatasource.removeFromFavorites(id, userId);
  }

  @override
  Future<List<ListingModel>> getFavoritesByUserId(String userId) async {
    try {
      // Fetch the raw data from the data source
      List<Map<String, dynamic>> listingsData =
          await favoriteRemoteDatasource.getFavoritesByUserId(userId);
      // Convert each Map<String, dynamic> into a ListingModel
      List<ListingModel> listings = listingsData.map((data) {
        return ListingModel.fromJson(data);
      }).toList();

      return listings;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<UserModel> getUserDataById(String id) async {
    try {
      Map<String, dynamic> userData =
          await favoriteRemoteDatasource.getUserDataById(id);
      UserModel user = UserModel.fromJson(userData);
      return user;
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
