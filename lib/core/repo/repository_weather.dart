import 'dart:convert';

import 'package:weather_application/core/models/daily_model.dart';
import 'package:http/http.dart' as http;

class RepositoryWeather {
  // final WeatherApi _weatherApi;

  // RepositoryWeather(this._weatherApi);

  // Future<Weather> getWeather(String city) async {
  //   return _weatherApi.getWeather(city);
  // }
  //https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=is_day&daily=weather_code,temperature_2m_max,temperature_2m_min,uv_index_max
  Future<DailyDTO> getWeather() async {
    final url = Uri.https('api.open-meteo.com', 'v1/forecast', {
      'latitude': '34.923096',
      'longitude': '33.634045',
      'current': 'temperature_2m,is_day',
      'daily': [
        'weather_code',
        'temperature_2m_max',
        'temperature_2m_min',
        'uv_index_max'
      ],
    });
    final http.Response response = await http.get(url);
    final Map decodedBody = jsonDecode(response.body);
    print(decodedBody);
    return DailyDTO.fromJson(decodedBody['daily']);
  }
}
