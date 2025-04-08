import 'package:flutter/material.dart';
import 'package:weather_application/core/repo/repository_weather.dart';
import 'package:weather_application/screens/home/state/models/day_model.dart';

class WeatherProvider with ChangeNotifier {
  List<DayModel> days = [];

  Future<void> init() async {
    final dailyModel = await RepositoryWeather().getWeather(
        // Change 1
        34.923096,
        33.634045); // Change 2
    for (var i = 0; i < dailyModel.time.length; i++) {
      days.add(DayModel(
        date: dailyModel.time[i],
        maxTemp: dailyModel.tempMax[i],
        minTemp: dailyModel.tempMin[i],
        weatherCode: dailyModel.weatherCode[i],
        uvIndexMax: dailyModel.uvIndexMax[i],
      ));
    }
    notifyListeners();
  }
}
