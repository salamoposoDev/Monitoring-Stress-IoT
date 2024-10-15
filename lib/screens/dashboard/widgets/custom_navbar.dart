import 'package:flutter/material.dart';
import 'package:monitoring_stress/screens/dashboard/dashboard.dart';
import 'package:monitoring_stress/screens/history/history_page.dart';
import 'package:monitoring_stress/screens/profile/profile_page.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  int selectedIndex = 0;
  final items = [
    BottomNavigationBarItem(
        icon: Image.asset(
          'lib/icons/icons8-dashboard-48.png',
          color: Colors.blue,
          scale: 2,
        ),
        label: 'Dashboard'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'lib/icons/icons8-graph-48.png',
          color: Colors.blue,
          scale: 2,
        ),
        label: 'History'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'lib/icons/icons8-setting-48.png',
          color: Colors.blue,
          scale: 2,
        ),
        label: 'Profile'),
  ];

  final screens = [
    Dashboard(),
    HistoryPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: items,
      ),
      body: SafeArea(child: screens[selectedIndex]),
    );
  }
}
