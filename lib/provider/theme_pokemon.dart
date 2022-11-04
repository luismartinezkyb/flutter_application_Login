import 'package:flutter/foundation.dart';

class PokemonTheme with ChangeNotifier {
  String _text = "";

  PokemonTheme({String? selectedColor}) {
    _text = selectedColor!;
  }

  getPokemonTheme() => this._text;

  setPokemonTheme(String tema) {
    this._text = tema;
    notifyListeners();
  }
}
// class PokemonTheme with ChangeNotifier {
//   String _text = "";

//   String get text1 => _text;

//   Future<void> setBackgroundColor({required String value1}) async {
//     _text = value1;
//     notifyListeners();
//   }
// }
