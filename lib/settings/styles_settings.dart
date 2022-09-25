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
  final ThemeData base = ThemeData.light();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 231, 146, 26));
}
