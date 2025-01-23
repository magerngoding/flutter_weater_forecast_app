// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final int id;
  final String main;
  final String description;
  final String icon;
  final num temprature;
  final num pressure;
  final num humidity;
  final num wind;
  final DateTime dateTime;
  final String cityName;

  WeatherEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.temprature,
    required this.pressure,
    required this.humidity,
    required this.wind,
    required this.dateTime,
    required this.cityName,
  });

  @override
  List<Object> get props {
    return [
      id,
      main,
      description,
      temprature,
      pressure,
      humidity,
      wind,
      dateTime,
      cityName,
    ];
  }
}
