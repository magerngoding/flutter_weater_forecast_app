import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weater_forecast/common/app_session.dart';
import 'package:flutter_weater_forecast/features/weather/domain/entities/weather_entity.dart';
import 'package:flutter_weater_forecast/features/weather/domain/usecases/get_current_weater_use_case.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final GetCurrentWeatherUseCase _useCase;
  final AppSession _appSession;

  CurrentWeatherBloc(
    this._useCase,
    this._appSession,
  ) : super(CurrentWeatherInitial()) {
    on<OnGetCurrentWeather>((event, emit) async {
      String? cityName = _appSession.cityName;
      if (cityName == null) return;

      emit(CurrentWeatherLoading());
      final result = await _useCase(cityName);
      result.fold(
        (failure) => emit(CurrentWeatherFailure(failure.message)),
        (data) => emit(CurrentWeatherSuccess(data)),
      );
    });
  }
}
