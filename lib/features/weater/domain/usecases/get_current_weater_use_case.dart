// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_weater_forecast/features/weater/domain/repositories/weater_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/weather_entity.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository _repository;

  GetCurrentWeatherUseCase(this._repository);

  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return _repository.getCurrentWeather(cityName);
  }
}