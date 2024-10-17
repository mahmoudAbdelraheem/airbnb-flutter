import 'package:airbnb_flutter/data/datasource/explore/get_categories_remote_datasource.dart';
import 'package:airbnb_flutter/data/datasource/explore/get_listings_remote_datasource.dart';
import 'package:airbnb_flutter/firebase_options.dart';
import 'package:airbnb_flutter/logic/explore/explore_bloc.dart';
import 'package:airbnb_flutter/repositories/explore/get_categories_repository.dart';
import 'package:airbnb_flutter/repositories/explore/get_listing_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  //! explore page dependancies
  _initExplore();

  //! Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void _initExplore() {
  // Register FirebaseFirestore instance
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

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
