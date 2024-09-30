import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather/cubit/weather_cubit.dart';
import 'package:weather_app/weather/view/search_page.dart';
import 'package:weather_app/weather/view/settings_page.dart';

import '../widgets/weather_empty.dart';
import '../widgets/weather_error.dart';
import '../widgets/weather_loading.dart';
import '../widgets/weather_populated.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).push<void>(SettingsPage.route()),
              icon: const Icon(Icons.settings)),
          IconButton(
            onPressed: () async {
              final city = await Navigator.of(context).push(SearchPage.route());
              if (!context.mounted) return;
              await context.read<WeatherCubit>().fetchWeather(city);
            },
            icon: const Icon(Icons.search, semanticLabel: 'Search'),
          ),
        ],
      ),
      body: Center(
        child:
            BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
          return switch (state.status) {
            WeatherStatus.initial => const WeatherEmpty(),
            WeatherStatus.loading => const WeatherLoading(),
            WeatherStatus.failure => const WeatherError(),
            WeatherStatus.success => WeatherPopulated(
                weather: state.weather,
                units: state.temperatureUnits,
                onRefresh: () {
                  return context.read<WeatherCubit>().refreshWeather();
                }),
          };
        }),
      ),
    );
  }
}
