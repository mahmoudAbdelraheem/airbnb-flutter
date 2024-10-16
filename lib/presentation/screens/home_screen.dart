import 'package:airbnb_flutter/presentation/screens/explore/explore_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> screens = [
    const ExploreScreen(),
    const Scaffold(
      body: Center(
        child: Text('wishlist screen'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('trips screen'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('profile screen'),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[200],
          currentIndex: _currentIndex,
          onTap: (int selectedIndex) {
            setState(() {
              _currentIndex = selectedIndex;
            });
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
    );
  }
}
