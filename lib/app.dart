import 'package:flutter/material.dart';
import 'package:weather_application/screens/home/home_screen_2.dart';

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return
        /*ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child:
      */
        MaterialApp(
      title: 'Weather Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
    //   );
  }
}
