import 'core/constants/app_constants.dart';
import 'data/models/listing_model.dart';
import 'init_dependancies.dart';
import 'logic/auth/auth_bloc.dart';
import 'logic/details/details_bloc.dart';
import 'logic/favorite/favorite_bloc.dart';
import 'logic/home/home_bloc.dart';
import 'logic/reservation/reservation_bloc.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/signup_screen.dart';
import 'presentation/screens/details/details_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/map/full_map_screen.dart';
import 'presentation/screens/pesonal_info/personal_info_screen.dart';
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
        return createSlideTransition(BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
          child: const LoginScreen(),
        ));
      //! login screen with slide transition
      case AppConstants.registerScreen:
        return createSlideTransition(BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
          child: const SignupScreen(),
        ));
      //! listing details Screen
      case AppConstants.detailsScreen:
        final Map<String, dynamic> data =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => serviceLocator<DetailsBloc>()
                    ..add(
                      GetHostAndReviewsDetailsEvent(
                        hostId: data['listing'].userId,
                      ),
                    ),
                ),
                BlocProvider(
                  create: (context) => serviceLocator<FavoriteBloc>(),
                ),
                BlocProvider(
                  create: (context) => serviceLocator<HomeBloc>()
                    ..add(
                      HomeGetCurrentUserEvent(),
                    ),
                ),
                BlocProvider(
                  create: (context) => serviceLocator<ReservationBloc>()
                    ..add(
                      GetReservationsByListingIdEvent(
                          listingId: data['listing'].id),
                    ),
                ),
              ],
              child: DetailsScreen(
                listing: data['listing'] as ListingModel,
                isFavorite: data['isFavorite'] as bool,
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
      //! listing pesonal info Screen
      case AppConstants.pesonalInfoScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (_) => serviceLocator<HomeBloc>()
                ..add(
                  HomeGetCurrentUserEvent(),
                ),
              child: const PersonalInfoScreen(),
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
