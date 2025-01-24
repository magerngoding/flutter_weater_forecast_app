import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weater_forecast/features/weater/data/models/weather_model.dart';
import 'package:flutter_weater_forecast/features/weater/domain/entities/weather_entity.dart';

import '../../../../helpers/dummy_data/weather_data.dart';
import '../../../../helpers/json_reader.dart';

void main() {
  test(
    'should a sub class [WeatherEntity]',
    () async {
      // arrange = mengatur

      // action = bertindak

      // assert = menegaskan
      // cara baca : apakah weathermodel adalah weaterentity ? YA
      expect(tWeatherModel, isA<WeatherEntity>());
    },
  );

  test(
    'should return valid model from json',
    () async {
      // arrange = mengatur
      String jsonString = readJson('current_weather.json');
      // perubahan jsonString ke jsonMap
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      // action = bertindak
      final result = WeatherModel.fromJson(jsonMap);

      // assert = menegaskan
      expect(result, tWeatherModel);
    },
  );

  test(
    'should return a valid json map',
    () async {
      // act
      final result = tWeatherModel.toJson();

      // assert
      expect(result, tWeatherJsonMap);
    },
  );
  test(
    'should return a valid [WeatherEntity]',
    () async {
      // act
      final result = tWeatherModel.toEntity;

      // assert
      expect(result, tWeatherEntity);
    },
  );
}
