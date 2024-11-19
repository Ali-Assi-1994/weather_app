import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather/data/weather_repository.dart';
import 'package:weather_app/features/weather/domain/weather_model.dart';

final weatherDataProvider = FutureProvider<WeatherModel>((ref) async {
  WeatherModel model = await ref.read(weatherRepositoryProvider).fetchData();

  /// data polling
  final timer = Timer(const Duration(minutes: 5), () => ref.invalidateSelf());
  ref.onDispose(timer.cancel);

  return model;
});

final selectedDayForecastProvider = StateProvider<DayForecast?>((ref) {
  final weatherData = ref.watch(weatherDataProvider).value;
  return weatherData?.days.elementAt(0);
});

enum TemperatureUnit { celsius, fahrenheit }

final temperatureUnitProvider = StateProvider<TemperatureUnit>((ref) => TemperatureUnit.celsius);
