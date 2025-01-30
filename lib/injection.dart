import 'package:flutter_weater_forecast/common/app_session.dart';
import 'package:flutter_weater_forecast/features/pick_place/presentation/cubit/city_cubit.dart';
import 'package:flutter_weater_forecast/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:flutter_weater_forecast/features/weather/data/repositories/weater_repository_impl.dart';
import 'package:flutter_weater_forecast/features/weather/domain/repositories/weater_repository.dart';
import 'package:flutter_weater_forecast/features/weather/domain/usecases/get_current_weater_use_case.dart';
import 'package:flutter_weater_forecast/features/weather/domain/usecases/get_hourly_forecase_use_case.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/bloc/current_weather/current_weather_bloc.dart';
import 'package:flutter_weater_forecast/features/weather/presentation/bloc/hourly_forecast/hourly_forecast_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> initLocator() async {
  // regisDI cubit / bloc
  locator.registerFactory(() => CityCubit(locator()));
  locator.registerFactory(() => CurrentWeatherBloc(locator(), locator()));
  locator.registerFactory(() => HourlyForecastBloc(locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));
  locator.registerLazySingleton(() => GetHourlyForecastUseCase(locator()));

  // datasource
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(locator()),
  );

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeaterRepositoryImpl(locator()),
  );

  // common
  locator.registerLazySingleton(() => AppSession(locator()));

  // external dari package sharedP.
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
}
