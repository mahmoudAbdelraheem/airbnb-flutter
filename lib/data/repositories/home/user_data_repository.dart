import 'package:airbnb_flutter/data/datasource/home/user_data_remote_datasource.dart';
import 'package:airbnb_flutter/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDataRepository {
  Future<UserModel> getUserDataById(String id);
  Future<User?> checkCurrentUserStatus();
}

class UserDataRepositoryImp implements UserDataRepository {
  final UserDataRemoteDatasource userDataRemoteDatasource;
  UserDataRepositoryImp({required this.userDataRemoteDatasource});

  @override
  Future<User?> checkCurrentUserStatus() async {
    return await userDataRemoteDatasource.checkCurrentUserStatus();
  }

  @override
  Future<UserModel> getUserDataById(String id) async {
    try {
      Map<String, dynamic> userData =
          await userDataRemoteDatasource.getUserDataById(id);
      UserModel user = UserModel.fromJson(userData);
      return user;
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
