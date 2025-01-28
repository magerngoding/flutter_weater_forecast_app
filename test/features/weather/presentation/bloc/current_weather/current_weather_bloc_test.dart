import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weater_forecast/common/app_session.dart';
import 'package:flutter_weater_forecast/core/error/failure.dart';
import 'package:flutter_weater_forecast/features/weather/domain/usecases/get_current_weater_use_case.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/bloc/current_weather/current_weather_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/dummy_data/weather_data.dart';

class MockAppSession extends Mock implements AppSession {}

class MockGetCurrentWeatherUseCase extends Mock
    implements GetCurrentWeatherUseCase {}

void main() {
  late MockAppSession mockAppSession;
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late CurrentWeatherBloc bloc;

  setUp(() {
    mockAppSession = MockAppSession();
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    bloc = CurrentWeatherBloc(mockGetCurrentWeatherUseCase, mockAppSession);
  });

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'emits [CurrentWeatherLoading, CurrentWeaterSuccess]'
    'when usecase is success.',
    build: () {
      when(() => mockAppSession.cityName).thenReturn(tCityName);
      when(
        () => mockGetCurrentWeatherUseCase(any()),
      ).thenAnswer((_) async => Right(tWeatherEntity));

      return bloc;
    },
    act: (bloc) => bloc.add(OnGetCurrentWeather()),
    expect: () => [
      CurrentWeatherLoading(),
      CurrentWeatherSuccess(tWeatherEntity),
    ],
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'emits [CurrentWeatherLoading, CurrentWeaterFailure]'
    'when usecase is failed.',
    build: () {
      when(() => mockAppSession.cityName).thenReturn(tCityName);
      when(
        () => mockGetCurrentWeatherUseCase(any()),
      ).thenAnswer((_) async => Left(NotFoundFailure('not found')));

      return bloc;
    },
    act: (bloc) => bloc.add(OnGetCurrentWeather()),
    expect: () => [
      CurrentWeatherLoading(),
      CurrentWeatherFailure('not found'),
    ],
  );

  blocTest<CurrentWeatherBloc, CurrentWeatherState>(
    'emits []'
    'when appsession return null.',
    build: () {
      when(() => mockAppSession.cityName).thenReturn(null);
      when(
        () => mockGetCurrentWeatherUseCase(any()),
      ).thenAnswer((_) async => Left(NotFoundFailure('not found')));

      return bloc;
    },
    act: (bloc) => bloc.add(OnGetCurrentWeather()),
    expect: () => [],
  );
}
