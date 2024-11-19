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

final selectedDayForecastIndex = StateProvider<int>((ref) => 0);

final selectedDayForecastProvider = Provider<DayForecast?>((ref) {
  final weatherData = ref.watch(weatherDataProvider).value;
  final index = ref.watch(selectedDayForecastIndex);
  return weatherData?.days.elementAt(index);
});

enum TemperatureUnit { celsius, fahrenheit }

final temperatureUnitProvider = StateProvider<TemperatureUnit>((ref) => TemperatureUnit.celsius);
