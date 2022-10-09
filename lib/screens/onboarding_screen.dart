import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = TextStyle(
    fontSize: 62.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    Widget buildPage({
      required Color color,
      required String urlImage,
      required String backgroundImage,
      required String title,
      required String subtitle,
      required List<AnimatedText> frases,
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
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 1.5,
              child: Image.asset(
                urlImage,
                width: MediaQuery.of(context).size.width / 1,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 7,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    title,
                    speed: Duration(milliseconds: 700),
                    textStyle:
                        GoogleFonts.almendraSc(textStyle: colorizeTextStyle),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    title,
                    speed: Duration(milliseconds: 700),
                    textStyle:
                        GoogleFonts.almendraSc(textStyle: colorizeTextStyle),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    title,
                    speed: Duration(milliseconds: 700),
                    textStyle:
                        GoogleFonts.almendraSc(textStyle: colorizeTextStyle),
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                onTap: () {},
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 4,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 10,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 15,
                  top: MediaQuery.of(context).size.height / 70,
                  bottom: MediaQuery.of(context).size.height / 65,
                  right: MediaQuery.of(context).size.width / 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: Theme.of(context).backgroundColor,
                ),
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).dialogBackgroundColor,
                    fontSize: 20.0,
                    fontFamily: 'Agne',
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    onFinished: () {
                      print('El contador es $contador');
                      if (contador != 4) {
                        controller.animateToPage(contador + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                        //controller.jumpToPage(contador + 1);
                      }
                    },
                    pause: Duration(milliseconds: 5000),
                    isRepeatingAnimation: true,
                    repeatForever: false,
                    animatedTexts: frases,
                    onTap: () {},
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 6,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      tema.sethemeData(temaDia());
                    },
                    child: Text(''),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: CircleBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tema.sethemeData(temaNoche());
                    },
                    child: Text(''),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 75, 17, 5),
                      shape: CircleBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tema.sethemeData(temaCalido());
                    },
                    child: Text(''),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: CircleBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tema.sethemeData(temaAmarillo());
                    },
                    child: Text(''),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 210, 229, 34),
                      shape: CircleBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tema.sethemeData(temaAzul());
                    },
                    child: Text(''),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 50, 26, 231),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
            )
            // Center(
            //   child:
            //   // child: DefaultTextStyle(
            //   style: const TextStyle(
            //     fontSize: 30.0,
            //     fontFamily: 'Agne',
            //   ),
            //   child: AnimatedTextKit(
            //     animatedTexts: [
            //       TypewriterAnimatedText(title),
            //       TypewriterAnimatedText(title),
            //       TypewriterAnimatedText(
            //           'Do not patch bugs out, rewrite them'),
            //       TypewriterAnimatedText(
            //           'Do not test bugs out, design them out'),
            //     ],
            //     onTap: () {
            //       print("Tap Event");
            //     },
            //   ),
            // ),
            // child: AnimatedTextKit(
            //   animatedTexts: [TyperAnimatedText(title)],
            // ),
          ],
        ),
      );
    }

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
                  tema.sethemeData(temaNoche());
                  break;
                case 1:
                  tema.sethemeData(temaDia());
                  break;
                case 2:
                  tema.sethemeData(temaAmarillo());
                  break;
                case 3:
                  tema.sethemeData(temaAzul());

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
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo',
                frases: [
                  TypewriterAnimatedText('Bienvenido Maestro Pokemon...'),
                  TypewriterAnimatedText('Soy el profesor Willow...'),
                  TypewriterAnimatedText(
                      'Y estoy aqui para enseñarte todo sobre este mundo...'),
                  TypewriterAnimatedText(
                      'Seré tu acompañante esta vez para presentarte al equipo...'),
                  TypewriterAnimatedText('Dejame presentartelos...')
                ]),
            buildPage(
                color: Colors.green,
                backgroundImage: 'assets/backgroundRojo.png',
                urlImage: 'assets/candelaPNG.png',
                title: 'Team Valor',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo',
                frases: [
                  TypewriterAnimatedText('Soy la maestra Candela...'),
                  TypewriterAnimatedText(
                      'Soy la fundadora del Team Valor En Pokemon...'),
                  TypewriterAnimatedText(
                      'Nuestro principal fuerte son los pokemon de fuego...'),
                  TypewriterAnimatedText(
                      'Y cualquier tipo de poke con esas caracteristicas..'),
                  TypewriterAnimatedText(
                      'Ojala puedas unirte conmigo para atraparlos todos!'),
                ]),
            buildPage(
                color: Colors.green.shade100,
                backgroundImage: 'assets/backgroundAmarillo.png',
                urlImage: 'assets/sparkPNG.png',
                title: 'Team Instinct',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo',
                frases: [
                  TypewriterAnimatedText('Mi nombre es Spark...'),
                  TypewriterAnimatedText(
                      'Soy el dueño del team Instinto o Amarillo en este caso...'),
                  TypewriterAnimatedText(
                      'Nuestro fuerte son los pokemon te tipo electricos...'),
                  TypewriterAnimatedText(
                      'Aunque obviamente tenemos experiencia con todo tipo...'),
                  TypewriterAnimatedText(
                      'Ojala podamos encontrarnos pronto en nuestro equipo!')
                ]),
            buildPage(
                color: Colors.green.shade100,
                backgroundImage: 'assets/backgroundAzul.png',
                urlImage: 'assets/blanchePNG.png',
                title: 'Team Mystic',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo',
                frases: [
                  TypewriterAnimatedText('Hola futuro Maestro Pokemon!'),
                  TypewriterAnimatedText(
                      'Mi nombre es Blanche y soy la fundadora del team Mystic'),
                  TypewriterAnimatedText(
                      'Aunque algunos nos dicen team azul, En este team...'),
                  TypewriterAnimatedText(
                      'Nos especializamos en todo tipo de pokemones...'),
                  TypewriterAnimatedText(
                      'Pero nuestros favoritos son los de agua!...'),
                  TypewriterAnimatedText('Son Magnificos,¿No lo crees?')
                ]),
            buildPage(
                color: Colors.green.shade100,
                backgroundImage: 'assets/backgroundWillow.png',
                urlImage: 'assets/profesorWillow2.png',
                title: 'POKEMON',
                subtitle:
                    'Vas a empezar en el mundo pokemon, te presentaré a los equipos que existen en este mundo',
                frases: [
                  TypewriterAnimatedText(
                      'Y estos son los mejores maestros pokemon...'),
                  TypewriterAnimatedText(
                      'Pero que opinas, ¿Te ha agradado algun team?...'),
                  TypewriterAnimatedText(
                      'Al final del día tendras que elegir alguno de ellos...'),
                  TypewriterAnimatedText(
                      'Pero por el momento vamos a capturar a todos los pokes'),
                  TypewriterAnimatedText(
                      'Que nos encontremos por el camino en tu nueva aventura...'),
                  TypewriterAnimatedText('!Vamos alla!'),
                ]),
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
                Navigator.pushNamed(context, '/dash');
              },
            )
          : Container(
              color: Theme.of(context).backgroundColor,
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
                        activeDotColor: Theme.of(context).dialogBackgroundColor,
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
