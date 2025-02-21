class DailyDTO {
  DailyDTO({
    required this.time,
    required this.weatherCode,
    required this.tempMin,
    required this.tempMax,
    required this.uvIndexMax,
  });

  final List<DateTime> time;
  final List<int> weatherCode;
  final List<double> tempMin;
  final List<double> tempMax;
  final List<double> uvIndexMax;

  factory DailyDTO.fromJson(Map<String, dynamic> json) {
    return DailyDTO(
      weatherCode: (json['weather_code'] as List).cast<int>(),
      tempMax: (json['temperature_2m_max'] as List).cast<double>(),
      tempMin: (json['temperature_2m_min'] as List).cast<double>(),
      uvIndexMax: (json['uv_index_max'] as List).cast<double>(),
      time: _dateTimeParcer((json['time'] as List).cast<String>()),
    );
  }

  static List<DateTime> _dateTimeParcer(List<String> input) =>
      input.map((date) => DateTime.parse(date)).toList();
}
