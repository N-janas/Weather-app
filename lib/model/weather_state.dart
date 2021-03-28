import 'package:equatable/equatable.dart';
import 'package:weather_app/model/weather_model.dart';

// Stany jakie mogą wystąpić w aplikacji

class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final _weather;

  WeatherModel get getWeather => _weather;

  WeatherIsLoaded(this._weather);

  @override
  List<Object> get props => [this._weather];
}

class WeatherIsNotLoaded extends WeatherState {}
