import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/features/weather/application/weather_provider.dart';
import 'package:weather_app/features/weather/domain/weather_model.dart';
import 'package:weather_app/utils/extensions.dart';

class AdaptiveWeatherDetailsWidget extends ConsumerWidget {
  const AdaptiveWeatherDetailsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Determine if the device is in portrait or landscape mode based on width
        final bool isPortrait = constraints.maxWidth < 600;

        if (isPortrait) {
          return const PortraitWeatherDetailsWidget();
        } else {
          return const LandscapeWeatherDetailsWidget();
        }
      },
    );
  }
}

class PortraitWeatherDetailsWidget extends ConsumerWidget {
  const PortraitWeatherDetailsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DayForecast? selectedDayForecast = ref.watch(selectedDayForecastProvider);

    if (selectedDayForecast == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text(selectedDayForecast.dtTxt.weekdayName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 32),
          Row(
            children: [
              Text(selectedDayForecast.weather.first.description, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const LottieAssetBuilder(),
          const TemperatureWidget(),
          const WeatherTextsDetails(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class LandscapeWeatherDetailsWidget extends ConsumerWidget {
  const LandscapeWeatherDetailsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DayForecast? selectedDayForecast = ref.watch(selectedDayForecastProvider);

    if (selectedDayForecast == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedDayForecast.dtTxt.weekdayName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LottieAssetBuilder(),
              Column(
                children: [
                  TemperatureWidget(),
                  SizedBox(height: 24),
                  WeatherTextsDetails(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TemperatureWidget extends ConsumerWidget {
  const TemperatureWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DayForecast? selectedDayForecast = ref.watch(selectedDayForecastProvider);

    if (selectedDayForecast == null) {
      return const SizedBox.shrink();
    }

    final isCelsius = ref.watch(temperatureUnitProvider) == TemperatureUnit.celsius;
    final temperatureUnit = ref.watch(temperatureUnitProvider);
    double temperature = selectedDayForecast.main.temp;
    final displayTemperature = temperatureUnit == TemperatureUnit.celsius ? temperature.toCelsius() : temperature.toFahrenheit();
    final temperatureSymbol = temperatureUnit == TemperatureUnit.celsius ? '°C' : '°F';

    return Column(
      children: [
        Text(
          "${displayTemperature.toStringAsFixed(1)} $temperatureSymbol",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 40),
        ),
        Switch(
          value: isCelsius,
          inactiveTrackColor: Colors.deepOrange,
          activeTrackColor: Colors.lightBlue,
          activeThumbImage: const AssetImage('assets/icons/celsius.png'),
          inactiveThumbImage: const AssetImage('assets/icons/fahrenheit.png'),
          onChanged: (value) => ref.read(temperatureUnitProvider.notifier).state = value ? TemperatureUnit.celsius : TemperatureUnit.fahrenheit,
        ),
      ],
    );
  }
}

class LottieAssetBuilder extends ConsumerWidget {
  const LottieAssetBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DayForecast? selectedDayForecast = ref.watch(selectedDayForecastProvider);

    if (selectedDayForecast == null) {
      return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        // Fade transition between old and new Lottie assets
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Lottie.asset(
        selectedDayForecast.weather.first.icon.getWeatherLottieAsset,
        key: ValueKey<String>(selectedDayForecast.weather.first.icon),
      ),
    );
  }
}

class WeatherTextsDetails extends ConsumerWidget {
  const WeatherTextsDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DayForecast? selectedDayForecast = ref.watch(selectedDayForecastProvider);
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    if (selectedDayForecast == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Humidity: ${selectedDayForecast.main.humidity}%",
              style: textStyle,
            ),
            const SizedBox(height: 5),
            Text(
              "Pressure: ${selectedDayForecast.main.pressure} hPa",
              style: textStyle,
            ),
            const SizedBox(height: 5),
            Text(
              "Wind: ${selectedDayForecast.wind.speed.convertMetersPerSecondToKilometersPerHour} km/h",
              style: textStyle,
            ),
          ],
        ),
      ],
    );
  }
}
