import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:mockito/annotations.dart';
import 'package:weather_application/core/models/daily_model.dart';
import 'package:weather_application/core/repo/repository_weather.dart';

import 'weather_test.mocks.dart';

@GenerateMocks([RepositoryWeather])
Future<void> main() async {
  test('test weather', () async {
    final mockedRepositoryWeather = MockRepositoryWeather();
    when(mockedRepositoryWeather.getWeather(1, 2))
        .thenAnswer((_) async => DailyDTO(
              time: ['2023-10-01'].map((date) => DateTime.parse(date)).toList(),
              weatherCode: [1],
              tempMax: [30],
              tempMin: [20],
              uvIndexMax: [5],
            ));

    final result = await mockedRepositoryWeather.getWeather(1, 2);
    expect(result.isHot(0), true);
  });
}
