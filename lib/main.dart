import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_application/app.dart';

Future<void> main() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.deniedForever) {
    print('Location permissions are permanently denied');
  }
  Position position =
      await Geolocator.getCurrentPosition(locationSettings: locationSettings);
  print(position);
//  await RepositoryWeather().getWeather();
  runApp(const Application());
}

final LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);
