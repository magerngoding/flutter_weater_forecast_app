// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_weater_forecast/features/weather/domain/repositories/weater_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/weather_entity.dart';

class GetHourlyForecastUseCase {
  final WeatherRepository _repository;

  GetHourlyForecastUseCase(this._repository);

  Future<Either<Failure, List<WeatherEntity>>> call(String cityName) {
    return _repository.getHourlyForecast(cityName);
  }
}
