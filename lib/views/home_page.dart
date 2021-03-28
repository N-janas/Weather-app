import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

// Extensions
import 'package:weather_app/extensions/capitalize_string.dart';

// Model
import 'package:weather_app/model/weather_bloc.dart';
import 'package:weather_app/model/weather_repo.dart';
import 'package:weather_app/model/weather_event.dart';
import 'package:weather_app/model/weather_state.dart';

// View
import 'package:weather_app/views/change_localization.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  AppBar appBar = AppBar(
    elevation: 6.0,
    title: Text('Pogodynka 3000'),
  );

  // Tworzy drzewo widgetow podajac zapakowany do contextu bloc
  @override
  Widget build(BuildContext context) {
    // Inicjalizacja lokalizacji polskiej
    initializeDateFormatting('pl_PL').then((_) => null);

    return BlocProvider(
      // Tworzy Bloc z domyślnym (pustym) stanem i od razu uruchamia
      // pobranie domyślnej lokalizacji (Gliwice)
      create: (context) => WeatherBloc(InitialState(), WeatherRepo())
        ..add(FetchWeatherEvent('Gliwice')),
      child: WeatherViewWidget(appBar: appBar),
    );
  }
}

class WeatherViewWidget extends StatelessWidget {
  const WeatherViewWidget({
    Key key,
    @required this.appBar,
  }) : super(key: key);

  final AppBar appBar;
  // final ThemeData currentTheme;

  // Funkcje pomocnicze odpowiedzialne za formatowanie stringa z czasem
  String getDateTimeString(miliseconds) {
    var date = DateTime.fromMillisecondsSinceEpoch(miliseconds * 1000);
    return DateFormat('yyyy-MM-dd  kk:mm', 'pl_PL').format(date);
  }

  String getTimeString(miliseconds) {
    var date = DateTime.fromMillisecondsSinceEpoch(miliseconds * 1000);
    return DateFormat('kk:mm', 'pl_PL').format(date);
  }

  // Metoda do wytwarzania kart
  Widget generateCard({label, content, icon, ctx}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: ListTile(
                title: Text(
                  label,
                  style: Theme.of(ctx).textTheme.headline2,
                ),
                subtitle: Text(
                  content,
                  style: Theme.of(ctx).textTheme.subtitle2,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                icon,
                color: Colors.grey,
                size: 55.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Text(
                  'Więcej Opcji :',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Zmień lokalizację',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1, //TextStyle(fontSize: 15),
              ),
              leading: Icon(
                Icons.public,
                size: 27,
              ),
              onTap: () async {
                // Zamykamy menu
                Navigator.pop(context);
                final String newLocation = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeLocalization(),
                  ),
                );
                // Jeśli dostaniemy nazwe to pokazujemy pogode
                if (newLocation?.trim()?.isNotEmpty ?? false) {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(FetchWeatherEvent(newLocation));
                }
              },
            ),
            ListTile(
              title: Text(
                'Tryb dla osób starszych',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              leading: Icon(
                Icons.elderly,
                size: 27,
              ),
              onTap: () {
                // Zamknięcie menu
                Navigator.pop(context);
                // Ustawienie trybu
                if (EasyDynamicTheme.of(context).themeMode == ThemeMode.light) {
                  EasyDynamicTheme.of(context).changeTheme(dark: true);
                } else {
                  EasyDynamicTheme.of(context).changeTheme(dark: false);
                }
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: BlocProvider.of<WeatherBloc>(context),
        builder: (context, WeatherState state) {
          // Jeśli nowa pogoda jest ładowana to wyświetl ikone ładowania
          if (state is WeatherIsLoading)
            return Center(child: CircularProgressIndicator());
          else if (state is InitialState) {
            return Center(child: CircularProgressIndicator());
          }
          // Jeśli pogoda się załadowała to ją wyświetl
          else if (state is WeatherIsLoaded)
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Card(
                      color: Colors.red,
                      elevation: 4,
                      margin: EdgeInsets.all(10),
                      child: InkWell(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 20, 10, 4),
                                    child: Text(
                                      state.getWeather.city,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 3, 10, 0),
                                    child: Text(
                                      '${state.getWeather.description}'
                                          .capitalize(),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Image.network(
                                    state.getWeather.iconUrl,
                                    scale: 0.1,
                                  ),
                                  Text(
                                    '${state.getWeather.getTemp.floor()}°',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: generateCard(
                            label: 'Data i godzina pomiaru',
                            content:
                                getDateTimeString(state.getWeather.dateTime),
                            icon: Icons.access_time,
                            ctx: context,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: generateCard(
                            label: 'Ciśnienie',
                            content: '${state.getWeather.pressure} hPa',
                            icon: Icons.vertical_align_bottom,
                            ctx: context,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: generateCard(
                            label: 'Godziny Świt / Zmierzch',
                            content:
                                '${getTimeString(state.getWeather.sunrise)} ' +
                                    '/ ${getTimeString(state.getWeather.sunset)}',
                            icon: Icons.brightness_medium,
                            ctx: context,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          else
            return Center(
              child: Text(
                'Nie znaleziono lokalizacji\nWyszukaj ponownie',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
        },
      ),
    );
  }
}
