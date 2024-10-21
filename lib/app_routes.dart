import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/data/models/listing_model.dart';
import 'package:airbnb_flutter/init_dependancies.dart';
import 'package:airbnb_flutter/logic/details/details_bloc.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:airbnb_flutter/presentation/screens/auth/login_screen.dart';
import 'package:airbnb_flutter/presentation/screens/details/details_screen.dart';
import 'package:airbnb_flutter/presentation/screens/home_screen.dart';
import 'package:airbnb_flutter/presentation/screens/map/full_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //! home screen
      case AppConstants.homeScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => serviceLocator<HomeBloc>()
                ..add(
                  HomeGetCurrentUserEvent(),
                ),
              child: const HomeScreen(),
            );
          },
        );
      //! login screen with slide transition
      case AppConstants.loginScreen:
        return createSlideTransition(const LoginScreen());
      //! listing details Screen
      case AppConstants.detailsScreen:
        final ListingModel listing = settings.arguments as ListingModel;
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => serviceLocator<DetailsBloc>()
                ..add(GetHostAndReviewsDetailsEvent(hostId: listing.userId)),
              child: DetailsScreen(
                listing: listing,
              ),
            );
          },
        );
      //! listing Full map Screen
      case AppConstants.fullMapScreen:
        final List<String> listingLocation = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (_) {
            return FullMapScreen(
              listingLocation: listingLocation,
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

//! add slide animation on route
Route<dynamic> createSlideTransition(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide in from right
      const end = Offset.zero; // Settle at center
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
