part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final bool isCelsius;
  final String errMsg;
  final String cityName;

  const WeatherState(
    this.status,
    this.weather,
    this.cityName, {
    this.errMsg = '',
    this.isCelsius = true,
  });

  @override
  String toString() {
    return '''
    status: $status
    weather: $weather
    errMsg: $errMsg
    isCelsius: $isCelsius
    cityName: $cityName
    ''';
  }

  @override
  List<Object> get props => [status, weather, errMsg, isCelsius];
}
