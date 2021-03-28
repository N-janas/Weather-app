import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/model/weather_repo.dart';
import 'package:weather_app/model/weather_event.dart';
import 'package:weather_app/model/weather_state.dart';

// Schemat Business Logic Component

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo weatherRepo;

  WeatherBloc(WeatherState initialState, this.weatherRepo)
      : super(initialState);

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      // Zwracamy że aplikacja ładuje pogode
      yield WeatherIsLoading();

      // Pobieramy dane z api
      try {
        WeatherModel weatherModel = await weatherRepo.getWeather(event.city);
        yield WeatherIsLoaded(weatherModel);
      } catch (_) {
        yield WeatherIsNotLoaded();
      }
    }
  }
}
