class WeatherModel {
  final String cityName;
  final double temparature;
  final String mainCondition;

  WeatherModel({
    required this.cityName,
    required this.temparature,
    required this.mainCondition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json ['name'],
      temparature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
