import 'package:flutter/material.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;

  double _dimenFont = 1;

  ThemeProvider({int? selectedTheme}) {
    _themeData = selectedTheme == 1
        ? temaDia()
        : selectedTheme == 2
            ? temaNoche()
            : temaCalido();
  }

  getthemeData() => this._themeData;
  sethemeData(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}
