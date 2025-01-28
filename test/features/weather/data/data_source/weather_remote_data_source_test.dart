// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weater_forecast/api/key.dart';
import 'package:flutter_weater_forecast/api/urls.dart';
import 'package:flutter_weater_forecast/core/error/exception.dart';
import 'package:flutter_weater_forecast/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../../helpers/dummy_data/weather_data.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/weather_mock.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSourceImpl = WeatherRemoteDataSourceImpl(mockHttpClient);
  });

  test(
    'should return [weatherModel] when status code is 200',
    () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(readJson('current_weather.json'), 200),
      );
      // act
      final result = await remoteDataSourceImpl.getCurrentWeather(tCityName);

      // assert
      String countryCode = 'ID';
      Uri url = Uri.parse(
        '${URLs.base}/weather?q=$tCityName, $countryCode&appid=$apiKey',
      );
      verify(mockHttpClient.get(url));
      expect(result, tWeatherModel);
    },
  );

  test(
    'should return [notFoundException] when status code is 404',
    () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('not found', 404),
      );
      // act
      final result = remoteDataSourceImpl.getCurrentWeather(tCityName);

      // assert
      String countryCode = 'ID';
      Uri url = Uri.parse(
        '${URLs.base}/weather?q=$tCityName, $countryCode&appid=$apiKey',
      );
      verify(mockHttpClient.get(url));
      expect(result, throwsA(isA<NotFoundException>()));
    },
  );

  test(
    'should return [ServerException] when status code is 200 and 400',
    () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('server error', 400),
      );
      // act
      final result = remoteDataSourceImpl.getCurrentWeather(tCityName);

      // assert
      String countryCode = 'ID';
      Uri url = Uri.parse(
        '${URLs.base}/weather?q=$tCityName, $countryCode&appid=$apiKey',
      );
      verify(mockHttpClient.get(url));
      expect(result, throwsA(isA<ServerException>()));
    },
  );
}
