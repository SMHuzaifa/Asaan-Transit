
import 'package:flutter/material.dart';

import '../screens/near_stop_screen.dart';
import '../screens/route_planner_screen.dart';
import '../screens/show_transit_data_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const TransitScreen(),
    const RoutePlanner(),
    const NearbyStopsScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule Transit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions),
            label: 'Route Planning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ev_station),
            label: 'Near Stops',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}