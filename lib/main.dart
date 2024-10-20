import 'package:airbnb_flutter/app_routes.dart';
import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/theme/app_theme.dart';
import 'package:airbnb_flutter/init_dependancies.dart';
import 'package:airbnb_flutter/presentation/screens/authentication/login_screen.dart';
import 'package:airbnb_flutter/presentation/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //! all app dependancies initialization
  await initDependancies();
  runApp(Airbnb());
}

class Airbnb extends StatelessWidget {
  //! make this class singleton
  Airbnb._();
  static final Airbnb instance = Airbnb._();
  factory Airbnb() => Airbnb.instance;
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Airbnb Clone',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
        // initialRoute: AppConstants.homeScreen,
        home: _auth.currentUser != null
            ? const HomeScreen()
            : const LoginScreen());
  }
}
