import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('City'),
              ),
              onSubmitted: (val) {
                context.read<WeatherCubit>().fetchWeather(val);
                Navigator.of(context).pop();
              },
            ),
            Expanded(
                child: Center(
              child: Icon(
                Icons.wb_sunny_outlined,
                size: 300,
                color: Colors.grey.withAlpha(70),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
