import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';

class WeatherShow extends StatelessWidget {
  const WeatherShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
      switch (state.status) {
        case WeatherStatus.initial:
          return const Center(
              child: Text(
            'Choose a place',
            style: TextStyle(fontSize: 40),
          ));
        case WeatherStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case WeatherStatus.success:
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 40),
                Image.network(
                  state.weather.icon,
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 40),
                Text(
                  state.weather
                      .formattedTemp(state.weather.temp, state.isCelsius),
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 10),
                Text(
                  state.weather.weatherStateName,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  'Min: ${state.weather.formattedTemp(state.weather.minTemp, state.isCelsius)}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Max: ${state.weather.formattedTemp(state.weather.maxTemp, state.isCelsius)}',
                  style: const TextStyle(fontSize: 20),
                ),
                const Divider(),
                Expanded(
                  child: Center(
                    child: Text(
                      state.cityName,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          );
        case WeatherStatus.failure:
          return const Center(
              child: Text(
            'An error occurred',
            style: TextStyle(fontSize: 40),
          ));
      }
    });
  }
}
