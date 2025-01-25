// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weater_forecast/core/error/exception.dart';

import 'package:flutter_weater_forecast/core/error/failure.dart';
import 'package:flutter_weater_forecast/features/weater/data/data_source/weather_remote_data_source.dart';
import 'package:flutter_weater_forecast/features/weater/domain/entities/weather_entity.dart';
import 'package:flutter_weater_forecast/features/weater/domain/repositories/weater_repository.dart';

class WeaterRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  WeaterRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
    String cityName,
  ) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity);
    } on NotFoundException {
      return Left(NotFoundFailure('Not found'));
    } on ServerException {
      return Left(ServerFailure('Server error'));
    } on SocketException {
      return Left(ConnectionFailure('Failed connect to the network'));
    } catch (e) {
      debugPrint('Something Failure: $e');
      return Left(SomethingFailure('Something wrong occure'));
    }
  }
}
