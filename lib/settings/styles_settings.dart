import 'package:flutter/material.dart';

ThemeData temaDia() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(backgroundColor: Colors.red);
}

ThemeData temaNoche() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 75, 17, 5));
}

ThemeData temaCalido() {
  final ThemeData base = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.green,
    ),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
  );
  return base.copyWith(
    splashColor: Colors.purple[300],
    backgroundColor: Colors.purple[300],
    brightness: Brightness.light,
    secondaryHeaderColor: Colors.purple[300],
    scaffoldBackgroundColor: Colors.purple[100],
    colorScheme: ColorScheme.light(
      onPrimary: Colors.purple,
      onBackground: Colors.purple,
      background: Colors.purple,
      primary: Colors.purple,
      secondary: Colors.purple,
    ),
  );
}

ThemeData temaPerso() {
  final ThemeData base = ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.teal,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.teal,
        ),
      ),
      scaffoldBackgroundColor: Colors.grey[200],
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: Colors.teal[800],
      ));
  return base.copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.teal,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.teal,
        ),
      ),
      scaffoldBackgroundColor: Colors.grey[200],
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: Colors.teal[800],
      ));
}

ThemeData temaRojo() {
  final ThemeData base = ThemeData.fallback();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 50, 26, 231));
}

ThemeData temaAzul() {
  final ThemeData base = ThemeData.fallback();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 50, 26, 231));
}

ThemeData temaAmarillo() {
  final ThemeData base = ThemeData.fallback();
  //Gradient(colors: [Colors.amber, Colors.black26]);
  //LinearGradient(colors: [Colors.red, Colors.blue]);
  return base.copyWith(backgroundColor: Color.fromARGB(255, 50, 26, 231));
}

ThemeData temaPerso2() {
  final ThemeData base = ThemeData();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 50, 26, 231));
}
