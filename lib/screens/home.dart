import 'package:flutter/material.dart';
import 'package:test/screens/weather.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 250,
          child: WeatherScreen(),
        ),
      ],
    );
  }
}
