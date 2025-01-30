import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weater_forecast/features/weather/domain/usecases/get_hourly_forecase_use_case.dart';

import '../../../../../common/app_session.dart';
import '../../../domain/entities/weather_entity.dart';

part 'hourly_forecast_event.dart';
part 'hourly_forecast_state.dart';

class HourlyForecastBloc
    extends Bloc<HourlyForecastEvent, HourlyForecastState> {
  final GetHourlyForecastUseCase _useCase;
  final AppSession _appSession;

  HourlyForecastBloc(this._useCase, this._appSession)
      : super(HourlyForecastInitial()) {
    on<OnGetHourlyForecast>((event, emit) async {
      String? cityName = _appSession.cityName;
      if (cityName == null) return;

      emit(HourlyForecastLoading());
      final result = await _useCase(cityName);
      result.fold(
        (failure) => emit(HourlyForecastFailure(failure.message)),
        (data) => emit(HourlyForecastSuccess(data)),
      );
    });
  }
}
