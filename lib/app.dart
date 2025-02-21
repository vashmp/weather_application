import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/screens/home/home_screen.dart';
import 'package:weather_application/screens/home/state/weather_provider.dart';

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider()..init(),
      child: MaterialApp(
        title: 'Weather Application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
