import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/splash_screen_view.dart';

//int estilo = 1;

void sharedMethod(int numTema) async {
  final prefs = await SharedPreferences.getInstance();

  //LEE
  final int? counter = prefs.getInt('numTema');
  if (counter != null) {
    //ELIMINA
    print('SI EXISTE UN TEMA Y ERA: $counter');
    final success = await prefs.remove('numTema');
  }
  //DECLARA
  await prefs.setInt('numTema', numTema);
}

// ThemeData temaChecar() {
//   print('ENTRA AL METODO PARA CHECAR CON ESTILO');
//   switch (estilo) {
//     case 1:
//       return temaDia();
//       break;
//     case 2:
//       return temaNoche();
//       break;
//     case 3:
//       return temaCalido();
//       break;
//   }
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//       backgroundColor: Colors.red, dialogBackgroundColor: Colors.white);
// }

ThemeData temaDia() {
  print('Se acaba de cambiar al Color Dia');
  sharedMethod(1);
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      backgroundColor: Colors.red, dialogBackgroundColor: Colors.white);
}

ThemeData temaNoche() {
  sharedMethod(2);
  print('Se acaba de cambiar al Color Noche');
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: Color.fromARGB(255, 75, 17, 5),
    dialogBackgroundColor: Colors.white,
  );
}

ThemeData temaCalido() {
  sharedMethod(3);
  print('Se acaba de cambiar al Color Calido');
  final ThemeData base = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.green,
    ),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
  );
  return base.copyWith(
    splashColor: Colors.purple[300],
    backgroundColor: Colors.purple[300],
    dialogBackgroundColor: Colors.black,
    brightness: Brightness.light,
    secondaryHeaderColor: Colors.white,
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

ThemeData temaAmarillo() {
  final ThemeData base = ThemeData.light();
  // Gradient(colors: [Colors.amber, Colors.black26]);
  // LinearGradient(colors: [Colors.red, Colors.blue]);
  // return base.copyWith(
  //     backgroundColor: Color.lerp(Colors.red, Colors.blue, 0.5));
  return ThemeData(
      primaryTextTheme: TextTheme(subtitle1: TextStyle(color: Colors.black)),
      textTheme: TextTheme(labelLarge: TextStyle(color: Colors.black)),
      splashColor: Colors.purple[300],
      dialogBackgroundColor: Colors.purple,
      backgroundColor: Color.fromARGB(255, 210, 229, 34),
      brightness: Brightness.light,
      secondaryHeaderColor: Colors.purple[300],
      scaffoldBackgroundColor: Colors.purple[100],
      colorScheme: ColorScheme.light(
        onPrimary: Colors.purple,
        onBackground: Colors.purple,
        background: Colors.purple,
        primary: Colors.purple,
        secondary: Colors.purple,
      ));
}

ThemeData temaRojo() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 231, 26, 26));
}

ThemeData temaAzul() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    backgroundColor: Color.fromARGB(255, 50, 26, 231),
    dialogBackgroundColor: Colors.white,
  );
}

// final ThemeData myTheme = ThemeData(
//     primarySwatch: MaterialColor(4282339839,{50: Color( 0xffe5e8ff )
// 		, 100: Color( 0xffccd1ff )
// 		, 200: Color( 0xff99a3ff )
// 		, 300: Color( 0xff6674ff )
// 		, 400: Color( 0xff3346ff )
// 		, 500: Color( 0xff0018ff )
// 		, 600: Color( 0xff0013cc )
// 		, 700: Color( 0xff000e99 )
// 		, 800: Color( 0xff000a66 )
// 		, 900: Color( 0xff000533 )
// 		}),
//     brightness: Brightness.light,
//     primaryColor: Color( 0xff3f51ff ),
//     primaryColorBrightness: Brightness.dark,
//     primaryColorLight: Color( 0xffccd1ff ),
//     primaryColorDark: Color( 0xff000e99 ),
//     accentColor: Color( 0xff0018ff ),
//     accentColorBrightness: Brightness.dark,
//     canvasColor: Color( 0xfffafafa ),
//     scaffoldBackgroundColor: Color( 0xfffafafa ),
//     bottomAppBarColor: Color( 0xffffffff ),
//     cardColor: Color( 0xffffffff ),
//     dividerColor: Color( 0x1f000000 ),
//     highlightColor: Color( 0x66bcbcbc ),
//     splashColor: Color( 0x66c8c8c8 ),
//     selectedRowColor: Color( 0xfff5f5f5 ),
//     unselectedWidgetColor: Color( 0x8a000000 ),
//     disabledColor: Color( 0x61000000 ),
//     buttonColor: Color( 0xffe0e0e0 ),
//     toggleableActiveColor: Color( 0xff0013cc ),
//     secondaryHeaderColor: Color( 0xffe5e8ff ),
//     textSelectionColor: Color( 0xff99a3ff ),
//     cursorColor: Color( 0xff4285f4 ),
//     textSelectionHandleColor: Color( 0xff6674ff ),
//     backgroundColor: Color( 0xff99a3ff ),
//     dialogBackgroundColor: Color( 0xffffffff ),
//     indicatorColor: Color( 0xff0018ff ),
//     hintColor: Color( 0x8a000000 ),
//     errorColor: Color( 0xffd32f2f ),
//     buttonTheme: ButtonThemeData(
//       textTheme: ButtonTextTheme.normal,
//       minWidth: 88,
//       height: 36,
//       padding: EdgeInsets.only(top:0,bottom:0,left:16, right:16),
//       shape:     RoundedRectangleBorder(
//       side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ),
//       borderRadius: BorderRadius.all(Radius.circular(2.0)),
//     ),
//       alignedDropdown: false ,
//       buttonColor: Color( 0xffe0e0e0 ),
//       disabledColor: Color( 0x61000000 ),
//       highlightColor: Color( 0x29000000 ),
//       splashColor: Color( 0x1f000000 ),
//       focusColor: Color( 0x1f000000 ),
//       hoverColor: Color( 0x0a000000 ),
//       colorScheme: ColorScheme(
//         primary: Color( 0xff3f51ff ),
//         primaryVariant: Color( 0xff000e99 ),
//         secondary: Color( 0xff0018ff ),
//         secondaryVariant: Color( 0xff000e99 ),
//         surface: Color( 0xffffffff ),
//         background: Color( 0xff99a3ff ),
//         error: Color( 0xffd32f2f ),
//         onPrimary: Color( 0xffffffff ),
//         onSecondary: Color( 0xffffffff ),
//         onSurface: Color( 0xff000000 ),
//         onBackground: Color( 0xffffffff ),
//         onError: Color( 0xffffffff ),
//         brightness: Brightness.light,
//       ),
//     ),
//   );