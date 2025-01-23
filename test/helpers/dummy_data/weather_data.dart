import 'package:flutter_weater_forecast/features/weater/domain/entities/weather_entity.dart';

const tCityName = 'Zocca';

final tWeatherEntity = WeatherEntity(
  id: 501,
  main: 'Rain',
  description: 'Moderate rain',
  icon: '10d',
  temprature: 298.48,
  pressure: 1015,
  humidity: 64,
  wind: 0.62,
  dateTime: DateTime.fromMillisecondsSinceEpoch(1661870592 * 1000),
  cityName: 'Zocca',
);
