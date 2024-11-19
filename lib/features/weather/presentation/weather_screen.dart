import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather/application/weather_provider.dart';
import 'package:weather_app/features/weather/domain/weather_model.dart';
import 'package:weather_app/features/weather/presentation/widgets/day_horizontal_list_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/theme_switch_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_details_widget.dart';
import 'package:weather_app/utils/widgets/retry_widget.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: ref.watch(weatherDataProvider).when(
                data: (weatherData) => WeatherDataWidget(weatherData: weatherData),
                error: (_, __) => const WeatherErrorWidget(),
                loading: () => const WeatherLoadingWidget(),
              ),
        ),
      ),
    );
  }
}

class WeatherDataWidget extends ConsumerWidget {
  final WeatherModel weatherData;

  const WeatherDataWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(weatherDataProvider.future),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const ThemeSwitchWidget(),
            const AdaptiveWeatherDetailsWidget(),
            DaysHorizontalListWidget(weatherData: weatherData),
          ],
        ),
      ),
    );
  }
}

class WeatherLoadingWidget extends StatelessWidget {
  const WeatherLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height - 326,
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class WeatherErrorWidget extends ConsumerWidget {
  const WeatherErrorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RetryWidget(
      retryFunction: () => ref.refresh(weatherDataProvider.future),
      height: MediaQuery.sizeOf(context).height * .13,
    );
  }
}
