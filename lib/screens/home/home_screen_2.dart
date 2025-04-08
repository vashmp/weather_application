import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_application/core/models/city_model.dart';
import 'package:weather_application/core/models/daily_model.dart';
import 'package:weather_application/core/repo/repository_weather.dart';

import 'state/models/day_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CityModel> cities = [
    CityModel(latitude: 56.00, longitude: 37.28, name: 'lobnya'),
    CityModel(latitude: -22.9, longitude: -43.19, name: 'rio'),
    CityModel(latitude: 51.0, longitude: 0, name: 'London'),
    CityModel(latitude: 48.2, longitude: 2, name: 'Paris'),
    CityModel(latitude: 34.923096, longitude: 33.634045, name: 'Limassol'),
    //  {'56.00' : '37,28'}, // lobnya
    //  {'-22.9' : '-43.19'}, // rio
    //  {'London' : '51,0'},
    //  {'Paris' : '48,2'},'34.923096': '33.634045'
  ];
  CityModel currentCity =
      CityModel(latitude: 34.923096, longitude: 33.634045, name: 'Limassol');

  @override
  initState() {
    super.initState();
    currentCity = cities[0];
  }

  List<DayModel> currentCityWeather = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RepositoryWeather()
          .getWeather(currentCity.latitude, currentCity.longitude),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          _dailyDTOParser(snapshot.data!);
        }
        return Scaffold(
            backgroundColor: Colors.blue,
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 50,
                      color: Colors.amber,
                    ),
                    Text(
                      currentCity.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 47,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Turn on location services',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 230,
                      height: 185,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              currentCityWeather.isEmpty
                                  ? ''
                                  : currentCityWeather[0]
                                      .maxTemp
                                      .round()
                                      .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 167,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '°C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 47,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('Cloudy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 47,
                          fontWeight: FontWeight.bold,
                        )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(150, 50),
                        backgroundColor: Colors.yellow,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.energy_savings_leaf,
                            color: Colors.white,
                          ),
                          const Text(
                            'AQI 14',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (currentCityWeather.isNotEmpty)
                      ...currentCityWeather.map((day) {
                        return dayWeather(
                          iconCode: weatherIcon(day.weatherCode),
                          weather: weatherCode(day.weatherCode).toString(),
                          dayOfWeek: DateFormat('d MMM').format(day.date),
                          maxTemp: day.maxTemp,
                          minTemp: day.minTemp,
                        );
                      }),
                    DropdownButton<CityModel>(
                      value: currentCity,
                      items: cities
                          .map((location) => DropdownMenuItem<CityModel>(
                                value: location,
                                child: Text(location.name),
                              ))
                          .toList(),
                      onChanged: (CityModel? city) {
                        setState(() {
                          if (city != null) {
                            currentCity = city;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  void _dailyDTOParser(DailyDTO dailyModel) {
    List<DayModel> days = [];

    for (var i = 0; i < dailyModel.time.length; i++) {
      days.add(DayModel(
        date: dailyModel.time[i],
        maxTemp: dailyModel.tempMax[i],
        minTemp: dailyModel.tempMin[i],
        weatherCode: dailyModel.weatherCode[i],
        uvIndexMax: dailyModel.uvIndexMax[i],
      ));
      currentCityWeather = days;
    }
  }

  Widget dayWeather(
      {required IconData iconCode,
      required String weather,
      required String dayOfWeek,
      required double maxTemp,
      required double minTemp}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6,
        left: 16,
        right: 16,
        bottom: 6,
      ),
      child: Row(
        children: [
          Icon(iconCode, color: Colors.white, size: 16.0),
          Text('$dayOfWeek • $weather',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
          Spacer(),
          Text('$minTemp° / $maxTemp°'),
        ],
      ),
    );
  }

  String weatherCode(int code) {
    switch (code) {
      case 0:
        return 'sunny';
      case 1:
        return 'partly cloudy';
      case 2:
        return 'cloudy';
      case 3:
        return 'sunny';
      case 10:
        return 'mist';
      case 21:
        return 'light rain';
      case 22:
        return 'moderate rain';
      case 23:
        return 'heavy rain';
      case 30:
        return 'light snow';
      case 31:
        return 'moderate snow';
      case 32:
        return 'heavy snow';
      case 40:
        return 'isolated thunderstorms';
      case 41:
        return 'thunderstorms';
      default:
        return 'unknown';
    }
  }
}

IconData weatherIcon(int code) {
  switch (code) {
    case 0:
      return Icons.wb_sunny;
    case 1:
      return Icons.wb_cloudy;
    case 2:
      return Icons.cloud;
    case 3:
      return Icons.wb_sunny;
    case 10:
      return Icons.cloud_queue;
    case 21:
      return Icons.cloud_queue;
    case 22:
      return Icons.cloud_queue;
    case 23:
      return Icons.cloud_queue;
    case 30:
      return Icons.ac_unit;
    case 31:
      return Icons.ac_unit;
    case 32:
      return Icons.ac_unit;
    case 40:
      return Icons.flash_on;
    case 41:
      return Icons.flash_on;
    default:
      return Icons.help;
  }
}
