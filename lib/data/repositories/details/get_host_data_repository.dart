import '../../datasource/details/get_host_data_remote_datasource.dart';
import '../../models/review_model.dart';
import '../../models/user_model.dart';

abstract class GetHostDataRepository {
  Future<UserModel> getHostDataById(String id);
  Future<List<ReviewModel>> getReviewsByHostId(String id);
}

class GetHostDataRepositoryImp implements GetHostDataRepository {
  final GetHostDataRemoteDatasource hostDtaRemoteDatasource;

  GetHostDataRepositoryImp({required this.hostDtaRemoteDatasource});

  @override
  Future<UserModel> getHostDataById(String id) async {
    try {
      Map<String, dynamic> hostData =
          await hostDtaRemoteDatasource.getHostDataById(id);
      UserModel host = UserModel.fromJson(hostData);
      return host;
    } catch (e) {
      throw Exception("Error fetching host data: $e");
    }
  }

  @override
  Future<List<ReviewModel>> getReviewsByHostId(String id) async {
    try {
      List<Map<String, dynamic>> reviewsData =
          await hostDtaRemoteDatasource.getReviewsByHostId(id);

      List<ReviewModel> reviews = reviewsData.map((data) {
        return ReviewModel.fromJson(data);
      }).toList();

      return reviews;
    } catch (e) {
      throw Exception("Error fetching host data: $e");
    }
  }
}
