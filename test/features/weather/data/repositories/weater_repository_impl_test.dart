// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weater_forecast/core/error/exception.dart';
import 'package:flutter_weater_forecast/core/error/failure.dart';
import 'package:flutter_weater_forecast/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:flutter_weater_forecast/features/weather/data/repositories/weater_repository_impl.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/dummy_data/weather_data.dart';

class MockWeaterRemoteDataSource extends Mock
    implements WeatherRemoteDataSource {}

void main() {
  late WeaterRepositoryImpl repositoryImpl;
  late MockWeaterRemoteDataSource mockWeaterRemoteDataSource;

  setUp(() {
    mockWeaterRemoteDataSource = MockWeaterRemoteDataSource();
    repositoryImpl = WeaterRepositoryImpl(mockWeaterRemoteDataSource);
  });

  test(
    'should return [WeatherEntity] when remoteDataSource is success',
    () async {
      // arrange
      when(() => mockWeaterRemoteDataSource.getCurrentWeather(any()))
          .thenAnswer((_) async => tWeatherModel);

      // act
      final result = await repositoryImpl.getCurrentWeather(tCityName);

      // assert
      verify(() => mockWeaterRemoteDataSource.getCurrentWeather(tCityName));
      expect(result, Right(tWeatherEntity));
    },
  );

  test(
    'should return [NotFoundFailure]'
    'when remoteDataSource throw [NotFoundException]',
    () async {
      // arrange
      when(
        () => mockWeaterRemoteDataSource.getCurrentWeather(any()),
      ).thenThrow(NotFoundException());

      // act
      final result = await repositoryImpl.getCurrentWeather(tCityName);

      // assert
      verify(() => mockWeaterRemoteDataSource.getCurrentWeather(tCityName));
      expect(result, Left(NotFoundFailure('Not found')));
    },
  );

  test(
    'should return [ServerFailure]'
    'when remoteDataSource throw [ServerFailure]',
    () async {
      // arrange
      when(
        () => mockWeaterRemoteDataSource.getCurrentWeather(any()),
      ).thenThrow(ServerException());

      // act
      final result = await repositoryImpl.getCurrentWeather(tCityName);

      // assert
      verify(() => mockWeaterRemoteDataSource.getCurrentWeather(tCityName));
      expect(result, Left(ServerFailure('Server error')));
    },
  );

  test(
    'should return [ConnectionFailure]'
    'when remoteDataSource throw [SocketException]',
    () async {
      // arrange
      when(
        () => mockWeaterRemoteDataSource.getCurrentWeather(any()),
      ).thenThrow(SocketException('Failed connect to the network'));

      // act
      final result = await repositoryImpl.getCurrentWeather(tCityName);

      // assert
      verify(() => mockWeaterRemoteDataSource.getCurrentWeather(tCityName));
      expect(result, Left(ConnectionFailure('Failed connect to the network')));
    },
  );

  test(
    'should return [SomethingFailure]'
    'when remoteDataSource throw [ClientException]',
    () async {
      // arrange
      when(
        () => mockWeaterRemoteDataSource.getCurrentWeather(any()),
      ).thenThrow(ClientException('client error'));

      // act
      final result = await repositoryImpl.getCurrentWeather(tCityName);

      // assert
      verify(() => mockWeaterRemoteDataSource.getCurrentWeather(tCityName));
      expect(result, Left(SomethingFailure('Something wrong occure')));
    },
  );
}
