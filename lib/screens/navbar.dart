import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test/providers/weather_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/screens/home.dart';
// import 'package:location/location.dart';

import 'package:test/screens/pages.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Pages(),
    Text(
      'Saves',
      style: optionStyle,
    ),
  ];

  Future<void> _fetchWeatherData() async {
    await ref.read(weatherDataProvider.notifier).fetchWeatherData();
  }

  @override
  void initState() {
    _fetchWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //     elevation: 20,
      //     title: const Text('GoogleNavBar'),
      //     ),
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedPageIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: theme.colorScheme.primaryContainer,
              hoverColor: theme.colorScheme.primaryContainer,
              gap: 8,
              activeColor: theme.colorScheme.primary,
              iconSize: 26,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: theme.colorScheme.secondary,
              color: theme.colorScheme.onSecondary.withOpacity(0.6),
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.more_horiz_outlined,
                  text: 'More',
                ),
                GButton(
                  icon: Icons.bookmarks_outlined,
                  text: 'Saves',
                ),
              ],
              selectedIndex: _selectedPageIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedPageIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
