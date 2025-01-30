import 'dart:convert';

import 'package:flutter_weater_forecast/api/key.dart';
import 'package:flutter_weater_forecast/api/urls.dart';
import 'package:flutter_weater_forecast/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weater_forecast/features/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
  Future<List<WeatherModel>> getHourlyForecast(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client _client;

  WeatherRemoteDataSourceImpl(this._client);

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    String countryCode = 'ID';
    Uri url = Uri.parse(
      '${URLs.base}/weather?q=$cityName, $countryCode&appid=$apiKey',
    );

    final response = await _client.get(url);
    if (response.statusCode == 200) {
      // ambil body
      final responseBody = jsonDecode(response.body);
      return WeatherModel.fromJson(responseBody);
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<WeatherModel>> getHourlyForecast(String cityName) async {
    String countryCode = 'ID';
    Uri url = Uri.parse(
      '${URLs.base}/forecast?q=$cityName, $countryCode&appid=$apiKey',
    );

    final response = await _client.get(url);
    if (response.statusCode == 200) {
      // refactor here pas error maplists
      Map responseBody = jsonDecode(response.body);
      List list = responseBody['list'];
      return list.map((e) => WeatherModel.fromJson(Map.from(e))).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}
