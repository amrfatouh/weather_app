import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  String weatherStateName;
  String weatherStateAbbr;
  @JsonKey(name: 'applicable_date')
  DateTime date;
  double minTemp;
  double maxTemp;
  @JsonKey(name: 'the_temp')
  double temp;

  Weather.empty()
      : weatherStateAbbr = '',
        weatherStateName = '',
        date = DateTime.now(),
        minTemp = 0,
        maxTemp = 0,
        temp = 0;

  Weather({
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.temp,
  });

  Color get color {
    if (temp <= 10) return const Color.fromRGBO(50, 90, 210, 1);
    if (temp > 10 && temp <= 15) return const Color.fromRGBO(50, 140, 240, 1);
    if (temp > 15 && temp <= 20) return const Color.fromRGBO(110, 180, 240, 1);
    if (temp > 20 && temp <= 25) return const Color.fromRGBO(240, 180, 90, 1);
    if (temp > 25 && temp <= 30) return const Color.fromRGBO(240, 170, 30, 1);
    if (temp > 30) return const Color.fromRGBO(240, 120, 30, 1);
    return Colors.grey;
  }

  String get icon =>
      'https://www.metaweather.com/static/img/weather/png/$weatherStateAbbr.png';

  double toFahrenheit(double celsius) => (celsius - 32) * 5 / 9;

  String formattedTemp(double rawTemp, bool isCelsius) => isCelsius
      ? '${rawTemp.toStringAsFixed(2)} °C'
      : '${toFahrenheit(rawTemp).toStringAsFixed(2)} °F';

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
