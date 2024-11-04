import 'package:airbnb_flutter/data/datasource/home/user_data_remote_datasource.dart';
import 'package:airbnb_flutter/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDataRepository {
  Future<UserModel> getUserDataById(String id);
  Future<User?> checkCurrentUserStatus();
  Future<bool> logout();
  Future<bool> saveUserData(
    String id,
    UserModel userModel,
  );
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
      return UserModel.fromJson(userData);
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }

  @override
  Future<bool> logout() async {
    return await userDataRemoteDatasource.logout();
  }

  @override
  Future<bool> saveUserData(String id, UserModel userModel) async {
    try {
      return await userDataRemoteDatasource.saveUserData(
          id, userModel.toJson());
    } catch (e) {
      throw Exception("Error saving user data: $e");
    }
  }
}
