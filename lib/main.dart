import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/search_screen.dart';
import 'package:weather_app/weather_api_client.dart';
import 'package:weather_app/weather_bloc_observer.dart';
import 'package:weather_app/weather_show.dart';

void main() {
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: WeatherBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void showSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text('Settings', style: TextStyle(fontSize: 25))
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Celsius: ', style: TextStyle(fontSize: 18)),
                      Switch(
                        value: context.read<WeatherCubit>().state.isCelsius,
                        onChanged: (newVal) {
                          setDialogState(() {
                            context.read<WeatherCubit>().toggleUnit();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                  appBarTheme:
                      AppBarTheme(backgroundColor: state.weather.color),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: state.weather.color),
                  switchTheme: SwitchThemeData(
                    trackColor: MaterialStateProperty.all(state.weather.color),
                    thumbColor: MaterialStateProperty.all(state.weather.color),
                  )),
              home: Builder(builder: (context) {
                return Scaffold(
                    appBar: AppBar(
                      title: const Text('Weather App'),
                      actions: [
                        IconButton(
                            onPressed: () => showSettings(context),
                            icon: const Icon(Icons.settings))
                      ],
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const SearchScreen();
                        }));
                      },
                      child: const Icon(Icons.search),
                    ),
                    body: const WeatherShow());
              }),
            );
          },
        );
      }),
    );
  }
}
