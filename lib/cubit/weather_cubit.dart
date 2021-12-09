import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/weather_api_client.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherApiClient weatherApiClient = WeatherApiClient();
  WeatherCubit()
      : super(WeatherState(WeatherStatus.initial, Weather.empty(), ''));

  Future<void> fetchWeather(String city) async {
    emit(WeatherState(WeatherStatus.loading, state.weather, state.cityName,
        isCelsius: state.isCelsius));
    try {
      int woeid = await weatherApiClient.fetchId(city);
      String name = await weatherApiClient.fetchName(city);
      Weather weather = await weatherApiClient.fetchWeather(woeid);
      emit(WeatherState(WeatherStatus.success, weather, name,
          isCelsius: state.isCelsius));
    } on WeatherException catch (e) {
      emit(WeatherState(WeatherStatus.failure, Weather.empty(), state.cityName,
          errMsg: e.message, isCelsius: state.isCelsius));
    }
  }

  void toggleUnit() {
    emit(WeatherState(state.status, state.weather, state.cityName,
        isCelsius: !state.isCelsius));
  }
}
