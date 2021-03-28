import 'package:equatable/equatable.dart';

// Eventy jakie mogą wystąpić w aplikacji

class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final city;

  FetchWeatherEvent(this.city);

  @override
  List<Object> get props => [this.city];
}
