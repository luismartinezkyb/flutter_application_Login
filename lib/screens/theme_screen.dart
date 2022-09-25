import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class ThemeScreeen extends StatelessWidget {
  const ThemeScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        TextButton.icon(
          onPressed: () {
            tema.sethemeData(temaDia());
          },
          icon: Icon(Icons.brightness_1),
          label: Text('Light Theme'),
        ),
        TextButton.icon(
          onPressed: () {
            tema.sethemeData(temaNoche());
          },
          icon: Icon(Icons.dark_mode),
          label: Text('Dark Theme'),
        ),
        TextButton.icon(
          onPressed: () {
            tema.sethemeData(temaCalido());
          },
          icon: Icon(Icons.hot_tub_sharp),
          label: Text('Tema calido'),
        )
      ],
    );
  }
}
