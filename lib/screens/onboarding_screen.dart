import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/theme_provider.dart';
import '../settings/styles_settings.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int contador = 0;
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String backgroundImage,
    required String title,
    required String subtitle,
  }) {
    return Container(
        decoration: BoxDecoration(
          color: color,
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 1.5,
              child: Image.asset(
                urlImage,
                width: MediaQuery.of(context).size.width / 1,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    //Theme.of(context).backgroundColor,tema.sethemeData(temaNoche());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (value) => {
            setState(() {
              isLastPage = value == 4;
              contador = value;
              switch (contador) {
                case 0:
                  tema.sethemeData(temaDia());
                  break;
                case 1:
                  tema.sethemeData(temaNoche());
                  break;
                case 2:
                  tema.sethemeData(temaCalido());
                  break;
                case 3:
                  tema.sethemeData(temaPerso());

                  break;
                case 4:
                  tema.sethemeData(temaNoche());

                  break;
              }
            })
          },
          children: [
            buildPage(
                color: Colors.red,
                backgroundImage: 'assets/backgroundWillow.png',
                urlImage: 'assets/profesorWillow2.png',
                title: 'Bienvenido',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo'),
            buildPage(
                color: Colors.green,
                backgroundImage: 'assets/backgroundRojo.png',
                urlImage: 'assets/candelaPNG.png',
                title: 'Bienvenido',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo'),
            buildPage(
                color: Colors.green.shade100,
                backgroundImage: 'assets/backgroundAmarillo.png',
                urlImage: 'assets/sparkPNG.png',
                title: 'Bienvenido',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo'),
            buildPage(
                color: Colors.green.shade100,
                backgroundImage: 'assets/backgroundAzul.png',
                urlImage: 'assets/blanchePNG.png',
                title: 'Bienvenido',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo'),
            buildPage(
                color: Colors.green.shade100,
                backgroundImage: 'assets/backgroundWillow.png',
                urlImage: 'assets/profesorWillow2.png',
                title: 'Bienvenido',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.red,
                minimumSize: Size.fromHeight(80),
              ),
              child: ListTile(
                title:
                    Text("Gotta Catch 'Em All", style: TextStyle(fontSize: 24)),
                leading: Image.asset('assets/pokebola2.png'),
              ),
              onPressed: () async {
                Navigator.pop(context);
                print('hola');
              },
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text('SKIP'),
                    onPressed: () {
                      controller.jumpToPage(4);
                    },
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 5,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) {
                        controller.animateToPage(index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                        print(index);
                        setState(() {
                          contador = index;
                        });
                      },
                    ),
                  ),
                  TextButton(
                    child: Text('NEXT'),
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                  )
                ],
              ),
            ),
    );
  }
}
