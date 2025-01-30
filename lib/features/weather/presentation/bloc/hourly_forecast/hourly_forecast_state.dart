part of 'hourly_forecast_bloc.dart';

sealed class HourlyForecastState extends Equatable {
  const HourlyForecastState();

  @override
  List<Object> get props => [];
}

final class HourlyForecastInitial extends HourlyForecastState {}

class HourlyForecastLoading extends HourlyForecastState {}

class HourlyForecastFailure extends HourlyForecastState {
  final String message;

  HourlyForecastFailure(this.message);

  @override
  List<Object> get props => [message];
}

class HourlyForecastSuccess extends HourlyForecastState {
  final List<WeatherEntity> data;

  HourlyForecastSuccess(this.data);

  @override
  List<Object> get props => [data];
}
