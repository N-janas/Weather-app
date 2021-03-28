import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'package:weather_app/model/weather_model.dart';

class WeatherRepo {
  final domain = 'api.openweathermap.org';
  final extend = '/data/2.5/weather';

  Future<WeatherModel> getWeather(String city) async {
    var jsonStr = await rootBundle.loadString('assets/secret.json');
    final key = json.decode(jsonStr)['api_key'];

    // Request do pogodowego api, podając klucz i miasto
    final result = await http.Client().get(
        Uri.https(domain, extend, {'q': city, 'appid': key, 'lang': 'pl'}));

    // Jeśli zwrócony status jest inny niż OK(200) to wyrzuć wyjątek
    if (result.statusCode != 200) throw Exception();

    final response = json.decode(result.body);

    // Zwróć weather model zgodnie z danymi z Json'a
    return WeatherModel.fromJson(response);
  }
}
