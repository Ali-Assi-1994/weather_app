import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/ApiClient/api.dart';
import 'package:weather_app/features/weather/domain/weather_model.dart';

class WeatherRepository {
  final ApiClient apiClient;

  WeatherRepository({required this.apiClient});

  Future<WeatherModel> fetchData() async {
    ApiResult result = await apiClient.get(url: URLS.forecast, queryParameters: {});
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
