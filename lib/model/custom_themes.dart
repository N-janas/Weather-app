import 'package:flutter/material.dart';

// Dwa motywy

final normalTheme = ThemeData(
  primaryColor: Colors.red,
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 15), // Menu item
    headline3: TextStyle(
      // Tempereatura
      fontSize: 65,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    headline1: TextStyle(
      // Lokalizacja
      fontSize: 33,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      // Opis pogody
      fontSize: 19,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    headline2: TextStyle(
        // Tytuł karty
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: Colors.black),
    subtitle2: TextStyle(
      // Zawartość karty
      fontSize: 19,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
  ),
);

final elderlyTheme = ThemeData(
  primaryColor: Colors.red,
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 18), // Menu item
    headline3: TextStyle(
      // Tempereatura
      fontSize: 78,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    headline1: TextStyle(
      // Lokalizacja
      fontSize: 43,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      // Opis pogody
      fontSize: 23,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    headline2: TextStyle(
        // Tytuł karty
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black),
    subtitle2: TextStyle(
      // Zawartość karty
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),
);
