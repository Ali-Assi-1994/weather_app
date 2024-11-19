import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/ApiClient/api.dart';
import 'package:weather_app/features/weather/domain/weather_model.dart';

class WeatherRepository {
  final ApiClient apiClient;

  WeatherRepository({required this.apiClient});

  Future<WeatherModel> fetchData() async {
    ApiResult result = await apiClient.get(url: URLS.forecast, queryParameters: {
      "lat": "44.34",
      "lon": "10.99",
      "appid": const String.fromEnvironment('appid', defaultValue: 'e5fb42624d70e76deff42c44b69388d3'),
    });
    if (result.type == ApiResultType.success) {
      await Future.delayed(const Duration(seconds: 1));
      return WeatherModel.fromJson(result.data);
    } else {
      throw result.errorMessage;
    }
  }
}

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository(apiClient: ref.read(dioProvider));
});
