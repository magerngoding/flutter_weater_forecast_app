// ignore_for_file: unused_local_variable

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weater_forecast/core/error/failure.dart';
import 'package:flutter_weater_forecast/features/weather/domain/usecases/get_current_weater_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/dummy_data/weather_data.dart';
import '../../../../helpers/weather_mock.mocks.dart';

void main() {
  late MockWeaterRepository mockWeaterRepository;
  late GetCurrentWeatherUseCase useCase;

  setUp(() {
    mockWeaterRepository = MockWeaterRepository();
    useCase = GetCurrentWeatherUseCase(mockWeaterRepository);
  });

  // skenario test
  test(
    'should return [WeatherEntity] when repository success',
    () async {
      // arrange
      when(
        mockWeaterRepository.getCurrentWeather(any),
      ).thenAnswer(
        (_) async => Right(tWeatherEntity),
      );

      // act
      final result = await useCase.call(tCityName);

      // assert
      verify(mockWeaterRepository.getCurrentWeather(tCityName));
      expect(result, equals(Right(tWeatherEntity)));
    },
  );

  // skenario test
  test(
    'should return [NotFoundFailure] when repository failed',
    () async {
      // arrange
      when(
        mockWeaterRepository.getCurrentWeather(any),
      ).thenAnswer(
        (_) async => Left(NotFoundFailure('not found!')),
      );

      // act
      final result = await useCase(tCityName);

      // assert
      verify(mockWeaterRepository.getCurrentWeather(tCityName));
      expect(result, Left(NotFoundFailure('not found!')));
    },
  );
}
