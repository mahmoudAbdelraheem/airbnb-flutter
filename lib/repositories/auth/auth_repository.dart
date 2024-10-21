import 'package:airbnb_flutter/data/datasource/auth/auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<User> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<User> signInWithGoogle();
  Future<User> signInWithGithub();
}

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImp({required this.authRemoteDatasource});

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    return await authRemoteDatasource.signIn(email: email, password: password);
  }

  @override
  Future<User> signInWithGithub() {
    // TODO: implement signInWithGithub
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithGoogle() async {
    return await authRemoteDatasource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    return await authRemoteDatasource.signOut();
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    return await authRemoteDatasource.signUp(
      email: email,
      password: password,
      name: name,
    );
  }
}
