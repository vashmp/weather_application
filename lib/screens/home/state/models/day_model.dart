class DayModel {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final int weatherCode;
  final double uvIndexMax;

  DayModel(
      {required this.date,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherCode,
      required this.uvIndexMax});
}
