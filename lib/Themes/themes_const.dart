import 'package:flutter/material.dart';

final ThemeData customlighttheme = ThemeData(
//custom theme for the container and text

  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[300],
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 220, 220, 222),
      foregroundColor: Colors.black),
  //elevated button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromARGB(255, 186, 17, 102)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),
);
////
final ThemeData customdarktheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 52, 53, 65),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 62, 63, 75),
      foregroundColor: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromARGB(210, 186, 17, 101)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  ),
);

// rgba(62,63,75,255)
// rgba(52,53,65,255)
// rgba(247,247,248,255)
// rgba(255,255,255,255)
