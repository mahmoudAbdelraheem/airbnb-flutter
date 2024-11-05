import 'package:airbnb_flutter/data/datasource/explore/get_categories_remote_datasource.dart';
import 'package:airbnb_flutter/data/models/category_model.dart';

abstract class GetCategotiesRepository {
  Future<List<CategoryModel>> getCategories();
}

class GetCategotiesRepositoryImp implements GetCategotiesRepository {
  final GetCategoriesRemoteDatasource categoriesRemoteDatasource;

  GetCategotiesRepositoryImp({required this.categoriesRemoteDatasource});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      // Fetch the raw data from the data source
      List<Map<String, dynamic>> categoriesData =
          await categoriesRemoteDatasource.getCategories();
      // Convert each Map<String, dynamic> into a CategoryModel
      List<CategoryModel> listings = categoriesData.map((data) {
        return CategoryModel.fromJson(data);
      }).toList();
      return listings;
    } catch (e) {
      return [];
    }
  }
}
