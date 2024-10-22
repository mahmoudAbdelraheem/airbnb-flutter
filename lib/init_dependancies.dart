import 'package:airbnb_flutter/data/datasource/auth/auth_remote_datasource.dart';
import 'package:airbnb_flutter/data/datasource/details/get_host_data_remote_datasource.dart';
import 'package:airbnb_flutter/data/datasource/explore/get_categories_remote_datasource.dart';
import 'package:airbnb_flutter/data/datasource/explore/get_listings_remote_datasource.dart';
import 'package:airbnb_flutter/firebase_options.dart';
import 'package:airbnb_flutter/logic/auth/auth_bloc.dart';
import 'package:airbnb_flutter/logic/details/details_bloc.dart';
import 'package:airbnb_flutter/logic/explore/explore_bloc.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:airbnb_flutter/repositories/auth/auth_repository.dart';
import 'package:airbnb_flutter/repositories/details/get_host_data_repository.dart';
import 'package:airbnb_flutter/repositories/explore/get_categories_repository.dart';
import 'package:airbnb_flutter/repositories/explore/get_listing_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  //! Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register FirebaseFirestore instance
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  //! auth dependancies
  _initAuth();

//! home page dependancies
  _homeBloc();

  //! explore page dependancies
  _initExplore();

  //! details page dependancies
  _initDetails();
}

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

void _initExplore() {
  // Register the data source
  serviceLocator.registerLazySingleton<GetListingsRemoteDatasource>(
    () => GetListingsRemoteDatasourceImp(firestore: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetCategoriesRemoteDatasource>(
    () => GetCategoriesRemoteDatasourceImp(firestore: serviceLocator()),
  );

  // Register the repository
  serviceLocator.registerLazySingleton<GetListingsRepository>(
    () => GetListingsRepositoryImp(remoteDatasource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetCategotiesRepository>(
    () => GetCategotiesRepositoryImp(
        categoriesRemoteDatasource: serviceLocator()),
  );

  // Register the ExploreBloc
  serviceLocator.registerFactory<ExploreBloc>(
    () => ExploreBloc(
      listingsRepository: serviceLocator(),
      categoriesRepository: serviceLocator(),
    ),
  );
}

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
void _initDetails() {
  // Register the data source
  serviceLocator.registerLazySingleton<GetHostDataRemoteDatasource>(
    () => GetHostDataRemoteDatasourceImp(firestore: serviceLocator()),
  );

  // Register the repository
  serviceLocator.registerLazySingleton<GetHostDataRepository>(
    () => GetHostDataRepositoryImp(hostDtaRemoteDatasource: serviceLocator()),
  );

  // Register the DetailsBloc
  serviceLocator.registerFactory<DetailsBloc>(
    () => DetailsBloc(
      getHostData: serviceLocator(),
    ),
  );
}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

void _initAuth() {
  // Register the data source
  serviceLocator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImp(
      firebaseAuth: serviceLocator(),
      firestore: serviceLocator(),
    ),
  );

  // Register the repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(authRemoteDatasource: serviceLocator()),
  );

  // Register the DetailsBloc
  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(
      authRepository: serviceLocator(),
    ),
  );
}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

void _homeBloc() {
  // Register AuthCubit
  serviceLocator.registerLazySingleton(
    () => HomeBloc(
      firebaseAuth: serviceLocator<FirebaseAuth>(),
    ),
  );
}
