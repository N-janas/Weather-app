import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/model/custom_themes.dart';
import 'package:weather_app/views/home_page.dart';

void main() async {
  runApp(EasyDynamicThemeWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      theme: normalTheme,
      darkTheme: elderlyTheme,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: MainPage(),
    );
  }
}
