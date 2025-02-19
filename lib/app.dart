import 'package:flutter/material.dart';
import 'package:weather_application/screens/home/home_screen.dart';

class Application extends StatelessWidget{
  const Application({super.key});
@override
Widget build(BuildContext context){
  return MaterialApp(
    title: 'Weather Application',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomeScreen(),
  );
}
}