import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/counter_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:flutter_application_1/screens/video_prueba.dart';
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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong!'),
          );
        }
        if (snapshot.hasData) {
          print('user logged with: ${snapshot.data}');
          //FirebaseAuth.instance.currentUser!.providerData[0].providerId;

          if (snapshot.data!.providerData[0].providerId == 'password') {
            if (snapshot.data!.emailVerified) {
              return DashBoardScreen2();
            } else {
              return LoginScreen();
            }
          } else {
            return DashBoardScreen2();
          }
        } else {
          print('user not logged');
          return LoginScreen();
        }
      },
    );

    // if (verifyUser) {
    //   return DashBoardScreen2();
    // } else {
    //   return LoginScreen();
    // }
  }

  Widget verifyEmail() {
    return DashBoardScreen2();
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
