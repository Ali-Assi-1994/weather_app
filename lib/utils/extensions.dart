import 'package:intl/intl.dart';

extension SpeedConverterExtenstion on double {
  String get convertMetersPerSecondToKilometersPerHour => (this * 3.6).toStringAsFixed(2);
}

extension DateTimeFormatter on DateTime {
  String get weekdayName => DateFormat('EEEE').format(this);

  String get weekdayNameAbbreviation => DateFormat('EEE').format(this);
}


extension TemperatureConversion on double {
  double toCelsius() => this - 273.15;
  double toFahrenheit() => (this - 273.15) * 9 / 5 + 32;
}

extension GetWeatherLottieFromIconCode on String {
  String get getWeatherIcon2x => "https://openweathermap.org/img/wn/$this@2x.png";

  String get getWeatherIcon4x => "https://openweathermap.org/img/wn/$this@4x.png";

  String get getWeatherLottieAsset {
    switch (this) {
      // Clear Sky
      case '01d': // Clear sky during the day
        return 'assets/lottie/sunny.json';
      case '01n': // Clear sky during the night
        return 'assets/lottie/night.json';

      // Few Clouds
      case '02d':
        return 'assets/lottie/partly_cloudy.json';
      case '02n':
        return 'assets/lottie/cloudy_night.json';

      // Scattered Clouds
      case '03d':
        return 'assets/lottie/partly_cloudy.json';
      case '03n':
        return 'assets/lottie/cloudy_night.json';

      // Broken Clouds
      case '04d':
        return 'assets/lottie/partly_cloudy.json';
      case '04n':
        return 'assets/lottie/cloudy_night.json';

      // Shower Rain
      case '09d':
        return 'assets/lottie/partly_shower.json';
      case '09n':
        return 'assets/lottie/rainy_night.json';

      // Rain
      case '10d': // Rain during the day
        return 'assets/lottie/partly_shower.json';
      case '10n': // Rain during the night
        return 'assets/lottie/rainy_night.json';

      // Thunderstorm
      case '11d':
        return 'assets/lottie/thunder.json';
      case '11n':
        return 'assets/lottie/thunder.json';

      // Snow
      case '13d':
        return 'assets/lottie/snow_sunny.json';
      case '13n':
        return 'assets/lottie/snow_night.json';

      // Mist
      case '50d':
        return 'assets/lottie/mist.json';
      case '50n':
        return 'assets/lottie/mist.json';

      // Default case for unknown icons
      default:
        return 'assets/lottie/foggy.json';
    }
  }
}


