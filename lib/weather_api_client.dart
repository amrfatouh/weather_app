import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/models/weather.dart';

class WeatherException implements Exception {
  String message;

  WeatherException(this.message);
}

class WeatherApiClient {
  Client client;

  WeatherApiClient({Client? client}) : client = client ?? Client();

  Future<int> fetchId(String name) async {
    final result = await client.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?query=$name'));
    if (result.statusCode != 200) {
      throw WeatherException('Error while getting the place');
    }
    final body = jsonDecode(result.body) as List;
    if (body.isEmpty) {
      throw WeatherException('No places found');
    }
    return body.first['woeid'];
  }

  Future<String> fetchName(String name) async {
    final result = await client.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?query=$name'));
    if (result.statusCode != 200) {
      throw WeatherException('Error while getting the place');
    }
    final body = jsonDecode(result.body) as List;
    if (body.isEmpty) {
      throw WeatherException('No places found');
    }
    return body.first['title'];
  }

  Future<Weather> fetchWeather(int woeid) async {
    final result = await client
        .get(Uri.parse('https://www.metaweather.com/api/location/$woeid'));
    if (result.statusCode != 200) {
      throw WeatherException('Error while getting the place');
    }
    final body = jsonDecode(result.body);
    if ((body['consolidated_weather'] as List).isEmpty) {
      throw WeatherException('No weather found');
    }
    return Weather.fromJson((body['consolidated_weather'] as List).first);
  }
}
