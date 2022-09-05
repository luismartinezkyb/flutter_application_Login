import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/counter_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
//abajo de navigateRoute
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const LoginScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/logoitc.png",
      text: "New Application",
      textType: TextType.ScaleAnimatedText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
