import 'package:flutter_weater_forecast/features/weater/domain/repositories/weater_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateNiceMocks([
  MockSpec<WeatherRepository>(as: #MockWeaterRepository),
  MockSpec<http.Client>(as: #MockHttpClient),
])
void main() {}
