import 'package:flutter/material.dart';
import 'package:test/screens/movies.dart';
import 'package:test/screens/weather.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() {
    return _PagesState();
  }
}

class _PagesState extends State<Pages> {
  int _selectedPageIndex = 0;

  Widget _buildButton(String label, int index, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        height: 30,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: _selectedPageIndex == index
                ? theme.colorScheme.primary
                : theme.colorScheme.background,
            foregroundColor: _selectedPageIndex == index
                ? Colors.white
                : theme.colorScheme.primary,
          ),
          onPressed: () {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          child: Text(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 20),
              _buildButton('Weather', 0, theme),
              _buildButton('Movies', 1, theme),
              _buildButton('News', 2, theme),
              _buildButton('Music', 3, theme),
              _buildButton('Pokemon', 4, theme),
              const SizedBox(width: 20),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_selectedPageIndex == 0) const WeatherScreen(),
              if (_selectedPageIndex == 1) const MovieScreen(),
            ],
          ),
        ),
      ],
    );
  }
}
