import 'package:airbnb_flutter/data/datasource/home/favorite_remote_datasource.dart';

abstract class FavoriteRepository {
  Future<bool> removeFromFavorites(String id, String userId);
  Future<bool> addToFavorites(String id, String userId);
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
}
