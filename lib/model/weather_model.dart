class WeatherModel {
  final city;
  final temp;
  final pressure;
  final description;
  final sunrise;
  final sunset;
  final dateTime;
  // Ikona pogodowa
  final iconUrl;

  // Konwersja z kelwinow
  double get getTemp => temp - 273.15;

  WeatherModel(this.city, this.temp, this.pressure, this.description,
      this.sunrise, this.sunset, this.dateTime, this.iconUrl);

  // Konstruktor zwracający obiekt zbudowany na podstawie Json'a
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final url =
        'https://openweathermap.org/img/wn/${(json['weather'] as List).first['icon']}@2x.png';

    return WeatherModel(
      json['name'],
      json['main']['temp'],
      json['main']['pressure'],
      (json['weather'] as List).first['description'],
      json['sys']['sunrise'],
      json['sys']['sunset'],
      json['dt'],
      url,
    );
  }
}
