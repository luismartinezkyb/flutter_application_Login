import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/counter_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

// class SplashScreen extends StatelessWidget {
//   //const SplashScreen({super.key});
//   bool verifyUser = false;
//   void sharedMethod() async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String>? users = prefs.getStringList('user');
//     if (users != null) {
//       verifyUser = true;
//     }
//     print('Users check $verifyUser');
//     print(users);
//   }

// //abajo de navigateRoute
//   @override
//   Widget build(BuildContext context) {
//     sharedMethod();
//     return SplashScreenView(
//       navigateRoute: LoginScreen(),
//       duration: 3000,
//       imageSize: 130,
//       imageSrc: "assets/logoitc.png",
//       text: "Bienvenido",
//       textType: TextType.ScaleAnimatedText,
//       textStyle: const TextStyle(
//         fontSize: 30.0,
//       ),
//       backgroundColor: Colors.white,
//     );
//   }
// }

//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//*** */
//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//*** */
//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//*** */
//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//*** */
//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//***//*** */
//StateFUl
class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  bool verifyUser = false;
  void sharedMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? users = prefs.getStringList('user');
    if (users != null) {
      setState(() {
        verifyUser = true;
      });
    }
    print("USERS $users");
  }

  @override
  void initState() {
    sharedMethod();
    super.initState();
  }

  Widget newNavigate() {
    if (verifyUser) {
      return OnboardingPage();
    } else {
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: newNavigate(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/logoitc.png",
      text: "Bienvenido",
      textType: TextType.ScaleAnimatedText,
      textStyle: const TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
