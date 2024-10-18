import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/presentation/screens/details/details_screen.dart';
import 'package:airbnb_flutter/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //! home screen
      case AppConstants.homeScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const HomeScreen();
          },
        );
      //! listing details Screen
      case AppConstants.detailsScreen:
        final ListingModel listing = settings.arguments as ListingModel;
        return MaterialPageRoute(
          builder: (_) {
            return DetailsScreen(
              listing: listing,
            );
          },
        );

      //! default screen
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No route defined'),
              ),
            );
          },
        );
    }
  }
}
