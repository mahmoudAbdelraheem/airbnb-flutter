import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:airbnb_flutter/presentation/screens/explore/explore_screen.dart';
import 'package:airbnb_flutter/presentation/screens/profile/profile_screen.dart';
import 'package:airbnb_flutter/presentation/screens/trips/trips_screen.dart';
import 'package:airbnb_flutter/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> screens = [
    const ExploreScreen(),
    const WishlistScreen(),
    const TripsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoggedOutState) {
            Navigator.pushNamed(context, AppConstants.loginScreen);
          }
          if (state is HomeOnPageChangedState) {
            _currentIndex = state.pageIndex;
            setState(() {});
          }
        },
        child: Scaffold(
          body: screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey[200],
            currentIndex: _currentIndex,
            onTap: (int selectedIndex) {
              context
                  .read<HomeBloc>()
                  .add(HomeOnPageChangedEvent(index: selectedIndex));
            },
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            selectedItemColor: Colors.pink[500],
            items: const [
              BottomNavigationBarItem(
                icon: Icon(size: 30, Icons.search_outlined),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(size: 30, Icons.favorite_border_outlined),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(size: 30, Icons.flight_outlined),
                label: 'Trips',
              ),
              BottomNavigationBarItem(
                icon: Icon(size: 30, Icons.person_2_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
