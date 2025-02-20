class DailyModel {
  DailyModel(
      {required this.time,
      required this.weatherCode,
      required this.tempMin,
      required this.tempMax,
      required this.uvIndexMax});
  final List<DateTime> time;
  final List<int> weatherCode;
  final List<double> tempMin;
  final List<double> tempMax;
  final List<double> uvIndexMax;

  factory DailyModel.fromJson(Map<String, dynamic> json) {
    return DailyModel(
      time: _dateTimeParser(json['time']),
      weatherCode: json['weather_code'] as List<int>,
      tempMin: json['temperature_2m_min'] as List<double>,
      tempMax: json['temperature_2m_max'] as List<double>,
      uvIndexMax: json['uv_index_max'] as List<double>,
    );
  }

  static List<DateTime> _dateTimeParser(List<String> input) =>
      input.map((date) => DateTime.parse(date)).toList();
}
