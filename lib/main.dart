import 'package:airbnb_flutter/app_routes.dart';
import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/theme/app_theme.dart';
import 'package:airbnb_flutter/init_dependancies.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //! all app dependancies initialization
  await initDependancies();
  runApp(Airbnb());
}

class Airbnb extends StatelessWidget {
  //! make this class singleton
  const Airbnb._();
  static const Airbnb instance = Airbnb._();
  factory Airbnb() => Airbnb.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airbnb Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
      initialRoute: AppConstants.homeScreen,
    );
  }
}
