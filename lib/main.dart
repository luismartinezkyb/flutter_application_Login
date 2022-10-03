import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/counter_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/edit_profile_screen.dart';
import 'package:flutter_application_1/screens/listTask_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/screens/task_screen.dart';
import 'package:flutter_application_1/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeProvider(), child: PMSNApp());
  }
}

//CounterScreen
class PMSNApp extends StatelessWidget {
  const PMSNApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: tema.getthemeData(),
      home: const SplashScreen2(),
      routes: {
        '/dash': (BuildContext context) => DashBoardScreen2(),
        '/login': (BuildContext context) => LoginScreen(),
        '/task': (BuildContext context) => ListTaskScreen(),
        '/addTask': (BuildContext context) => TaskScreen(),
        '/userprofile': (BuildContext context) => UserProfileScreen(),
        '/editProfilePage': (BuildContext context) => EditProfilePage(),
      },
    );
  }
}
