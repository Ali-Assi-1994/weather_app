import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/weather/application/weather_provider.dart';
import 'package:weather_app/features/weather/data/weather_repository.dart';
import 'package:weather_app/features/weather/domain/weather_model.dart';

// Mock class for WeatherRepository
class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('Weather App Providers Tests', () {
    late MockWeatherRepository mockWeatherRepository;
    late ProviderContainer container;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      // Set up a container with the mocked repository
      container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(mockWeatherRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('weatherDataProvider fetches weather data correctly', () async {
      // Sample WeatherModel for testing
      final testWeatherModel = WeatherModel(
        cod: "200",
        message: 0,
        cnt: 1,
        days: [
          DayForecast(
            dt: 1637102400,
            main: MainClass(
              temp: 25.0,
              feelsLike: 24.5,
              tempMin: 22.0,
              tempMax: 27.0,
              pressure: 1012,
              seaLevel: 1012,
              grndLevel: 1000,
              humidity: 65,
              tempKf: 0.0,
            ),
            weather: [
              Weather(id: 800, main: MainEnum.CLEAR, description: "clear sky", icon: "01d"),
            ],
            clouds: Clouds(all: 10),
            wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
            visibility: 10000,
            pop: 0.0,
            sys: Sys(pod: Pod.D),
            dtTxt: DateTime.parse("2024-11-01 12:00:00"),
            rain: null,
            snow: null,
          ),
        ],
        city: City(
          id: 123,
          name: "Test City",
          coord: Coord(lat: 35.0, lon: 35.0),
          country: "Test Country",
          population: 500000,
          timezone: 18000,
          sunrise: 1637055600,
          sunset: 1637098800,
        ),
      );

      // Mock the fetchData method to return the testWeatherModel
      when(() => mockWeatherRepository.fetchData())
          .thenAnswer((_) async => testWeatherModel);

      // Act: Fetch the data
      final weatherModel = await container.read(weatherDataProvider.future);

      // Assert: Check the fetched data
      expect(weatherModel, isNotNull);
      expect(weatherModel.cod, "200");
      expect(weatherModel.city.name, "Test City");
      expect(weatherModel.days.first.main.temp, 25.0);
    });

    test('selectedDayForecastProvider initializes with the first forecast', () async {
      // Sample WeatherModel with multiple DayForecasts
      final testWeatherModel = WeatherModel(
        cod: "200",
        message: 0,
        cnt: 2,
        days: [
          DayForecast(
            dt: 1637102400,
            main: MainClass(
              temp: 25.0,
              feelsLike: 24.5,
              tempMin: 22.0,
              tempMax: 27.0,
              pressure: 1012,
              seaLevel: 1012,
              grndLevel: 1000,
              humidity: 65,
              tempKf: 0.0,
            ),
            weather: [
              Weather(id: 800, main: MainEnum.CLEAR, description: "clear sky", icon: "01d"),
            ],
            clouds: Clouds(all: 10),
            wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
            visibility: 10000,
            pop: 0.0,
            sys: Sys(pod: Pod.D),
            dtTxt: DateTime.parse("2024-11-01 12:00:00"),
            rain: null,
            snow: null,
          ),
          DayForecast(
            dt: 1637188800,
            main: MainClass(
              temp: 26.0,
              feelsLike: 25.0,
              tempMin: 23.0,
              tempMax: 28.0,
              pressure: 1011,
              seaLevel: 1011,
              grndLevel: 999,
              humidity: 60,
              tempKf: 0.0,
            ),
            weather: [
              Weather(id: 801, main: MainEnum.CLOUDS, description: "few clouds", icon: "02d"),
            ],
            clouds: Clouds(all: 20),
            wind: Wind(speed: 4.0, deg: 170, gust: 6.5),
            visibility: 10000,
            pop: 0.1,
            sys: Sys(pod: Pod.D),
            dtTxt: DateTime.parse("2024-11-02 12:00:00"),
            rain: null,
            snow: null,
          ),
        ],
        city: City(
          id: 123,
          name: "Test City",
          coord: Coord(lat: 35.0, lon: 35.0),
          country: "Test Country",
          population: 500000,
          timezone: 18000,
          sunrise: 1637055600,
          sunset: 1637098800,
        ),
      );

      // Mock the fetchData method to return the testWeatherModel
      when(() => mockWeatherRepository.fetchData())
          .thenAnswer((_) async => testWeatherModel);

      // Act: Trigger the weather data provider
      await container.read(weatherDataProvider.future);
      final selectedDay = container.read(selectedDayForecastProvider);

      // Assert: Check that the selected day matches the first entry
      expect(selectedDay, isNotNull);
      expect(selectedDay!.dtTxt, DateTime.parse("2024-11-01 12:00:00"));
    });

    test('temperatureUnitProvider initializes with celsius', () {
      final unit = container.read(temperatureUnitProvider);
      expect(unit, TemperatureUnit.celsius);
    });

    test('temperatureUnitProvider can switch between celsius and fahrenheit', () {
      // Initially set to celsius
      final temperatureUnit = container.read(temperatureUnitProvider.notifier);
      expect(temperatureUnit.state, TemperatureUnit.celsius);

      // Switch to fahrenheit
      temperatureUnit.state = TemperatureUnit.fahrenheit;
      expect(temperatureUnit.state, TemperatureUnit.fahrenheit);
    });

    test('getUniqueWeekdays correctly filters unique days', () {
      final testDays = [
        DayForecast(
          dt: 1637102400,
          main: MainClass(
            temp: 25.0,
            feelsLike: 24.5,
            tempMin: 22.0,
            tempMax: 27.0,
            pressure: 1012,
            seaLevel: 1012,
            grndLevel: 1000,
            humidity: 65,
            tempKf: 0.0,
          ),
          weather: [
            Weather(id: 800, main: MainEnum.CLEAR, description: "clear sky", icon: "01d"),
          ],
          clouds: Clouds(all: 10),
          wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
          visibility: 10000,
          pop: 0.0,
          sys: Sys(pod: Pod.D),
          dtTxt: DateTime.parse("2024-11-01 12:00:00"),
          rain: null,
          snow: null,
        ),
        DayForecast(
          dt: 1637188800,
          main: MainClass(
            temp: 26.0,
            feelsLike: 25.0,
            tempMin: 23.0,
            tempMax: 28.0,
            pressure: 1011,
            seaLevel: 1011,
            grndLevel: 999,
            humidity: 60,
            tempKf: 0.0,
          ),
          weather: [
            Weather(id: 801, main: MainEnum.CLOUDS, description: "few clouds", icon: "02d"),
          ],
          clouds: Clouds(all: 20),
          wind: Wind(speed: 4.0, deg: 170, gust: 6.5),
          visibility: 10000,
          pop: 0.1,
          sys: Sys(pod: Pod.D),
          dtTxt: DateTime.parse("2024-11-02 12:00:00"),
          rain: null,
          snow: null,
        ),
        // Duplicate weekday of the first entry but different date
        DayForecast(
          dt: 1637275200,
          main: MainClass(
            temp: 24.0,
            feelsLike: 23.5,
            tempMin: 21.0,
            tempMax: 26.0,
            pressure: 1013,
            seaLevel: 1013,
            grndLevel: 1001,
            humidity: 68,
            tempKf: 0.0,
          ),
          weather: [
            Weather(id: 802, main: MainEnum.CLOUDS, description: "scattered clouds", icon: "03d"),
          ],
          clouds: Clouds(all: 30),
          wind: Wind(speed: 3.0, deg: 160, gust: 5.5),
          visibility: 10000,
          pop: 0.2,
          sys: Sys(pod: Pod.D),
          dtTxt: DateTime.parse("2024-11-02 03:00:00"),
          rain: null,
          snow: null,
        ),
      ];

      final uniqueWeekdays = testDays.getUniqueWeekdays;

      // Check that the result contains only unique weekdays
      expect(uniqueWeekdays.length, 2);
      expect(uniqueWeekdays.first.dtTxt.weekday, DateTime.parse("2024-11-01 12:00:00").weekday);
    });
  });
}
