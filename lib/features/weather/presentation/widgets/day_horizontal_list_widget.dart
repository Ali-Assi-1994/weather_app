import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/features/weather/application/weather_provider.dart';
import 'package:weather_app/features/weather/domain/weather_model.dart';
import 'package:weather_app/utils/extensions.dart';

class DaysHorizontalListWidget extends ConsumerWidget {
  final WeatherModel weatherData;

  const DaysHorizontalListWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uniqueDayForecasts = weatherData.days.getUniqueWeekdays;

    return SizedBox(
      height: 100,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: uniqueDayForecasts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return DaysHorizontalItemBuilder(
              dayForecast: uniqueDayForecasts.elementAt(index),
              onTap: () => ref.read(selectedDayForecastIndex.notifier).state = index,
              isSelected: index == ref.watch(selectedDayForecastIndex),
            );
          },
        ),
      ),
    );
  }
}

class DaysHorizontalItemBuilder extends ConsumerWidget {
  final DayForecast dayForecast;
  final void Function() onTap;
  final bool isSelected;

  const DaysHorizontalItemBuilder({
    super.key,
    required this.dayForecast,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = isSelected ? Colors.blueAccent : Colors.transparent;
    final textColor = isSelected ? Colors.white : Theme.of(context).textTheme.labelLarge!.color;
    final fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;
    final padding = isSelected ? const EdgeInsets.all(8) : const EdgeInsets.all(8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dayForecast.dtTxt.weekdayNameAbbreviation,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
              ),
              const SizedBox(height: 8),
              Lottie.asset(
                dayForecast.weather.first.icon.getWeatherLottieAsset,
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
