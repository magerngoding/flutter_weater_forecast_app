part of 'current_weather_bloc.dart';

sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];
}

final class CurrentWeatherInitial extends CurrentWeatherState {}

final class CurrentWeatherLoading extends CurrentWeatherState {}

final class CurrentWeatherFailure extends CurrentWeatherState {
  final String message;

  CurrentWeatherFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class CurrentWeatherSuccess extends CurrentWeatherState {
  final WeatherEntity data;

  CurrentWeatherSuccess(this.data);

  @override
  List<Object> get props => [data];
}
