import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/ApiClient/api.dart';
import 'package:weather_app/features/weather/data/weather_repository.dart';

// Mock class for ApiClient
class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('WeatherRepository Tests', () {
    late MockApiClient mockApiClient;
    late WeatherRepository weatherRepository;
    late ProviderContainer container;

    setUp(() {
      mockApiClient = MockApiClient();
      weatherRepository = WeatherRepository(apiClient: mockApiClient);

      // Set up a provider container with the mocked repository
      container = ProviderContainer(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(weatherRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('fetchData returns WeatherModel on success', () async {
      // Sample JSON response for a successful API call
      final sampleJsonResponse = {
        "cod": "200",
        "message": 0,
        "cnt": 1,
        "list": [
          {
            "dt": 1637102400,
            "main": {
              "temp": 25.0,
              "feels_like": 24.5,
              "temp_min": 22.0,
              "temp_max": 27.0,
              "pressure": 1012,
              "sea_level": 1012,
              "grnd_level": 1000,
              "humidity": 65,
              "temp_kf": 0.0,
            },
            "weather": [
              {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d",
              }
            ],
            "clouds": {"all": 10},
            "wind": {"speed": 5.0, "deg": 180, "gust": 7.0},
            "visibility": 10000,
            "pop": 0.0,
            "sys": {"pod": "d"},
            "dt_txt": "2024-11-01 12:00:00"
          }
        ],
        "city": {
          "id": 123,
          "name": "Test City",
          "coord": {"lat": 35.0, "lon": 35.0},
          "country": "Test Country",
          "population": 500000,
          "timezone": 18000,
          "sunrise": 1637055600,
          "sunset": 1637098800,
        }
      };

      // Mocking the ApiClient's get method to return success
      when(() => mockApiClient.get(
        url: URLS.forecast,
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer((_) async => ApiResult(
        type: ApiResultType.success,
        data: sampleJsonResponse,
      ));

      // Act: Fetch the data using the repository
      final weatherData = await weatherRepository.fetchData();

      // Assert: Verify the WeatherModel is returned correctly
      expect(weatherData, isNotNull);
      expect(weatherData.cod, "200");
      expect(weatherData.city.name, "Test City");
      expect(weatherData.days.first.main.temp, 25.0);
    });

    test('fetchData throws error on failure', () async {
      // Mocking the ApiClient's get method to return an error
      when(() => mockApiClient.get(
        url: URLS.forecast,
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer((_) async => ApiResult(
        type: ApiResultType.failure,
        message: "Error fetching data",
      ));

      // Act & Assert: Expect fetchData to throw an error
      expect(
            () async => await weatherRepository.fetchData(),
        throwsA("Error fetching data"),
      );
    });
  });
}
