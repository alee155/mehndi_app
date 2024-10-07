import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mehndi_app/Screens/Profile/profile.dart';
import 'package:mehndi_app/Screens/SelectionScreen/Offline/Offlinehomescreen.dart';

class OfflineWelcomeScreen extends StatefulWidget {
  const OfflineWelcomeScreen({super.key});

  @override
  _OfflineWelcomeScreenState createState() => _OfflineWelcomeScreenState();
}

class _OfflineWelcomeScreenState extends State<OfflineWelcomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: const Color(0xFFFCEFDF), // Set background color here
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: const Color(0xFF74380e),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
            activeColor: const Color(0xFF74380e),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: const Color(0xFF74380e),
          ),
        ],
      ),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    const OfflineHomeScreen(),
    const ProfilePageWidget(),
    const ProfileManagement(),
  ];
}

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text('Coming Soon'),
      ),
    );
  }
}
