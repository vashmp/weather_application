import 'package:flutter/material.dart';
import 'package:weather_application/app.dart';
import 'package:weather_application/core/repo/repository_weather.dart';

Future<void> main() async {
  await RepositoryWeather().getWeather();
  runApp(const Application());
}
