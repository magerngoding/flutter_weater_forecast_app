import 'package:dartz/dartz.dart';
import 'package:flutter_weater_forecast/features/weater/domain/entities/weather_entity.dart';

import '../../../../core/error/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
