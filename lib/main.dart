import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/about_us_screen.dart';
import 'package:flutter_application_1/screens/apiPokemon/details_pokemon_screen.dart';
import 'package:flutter_application_1/screens/apiPokemon/list_all_pokes_screen.dart';
import 'package:flutter_application_1/screens/counter_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/edit_profile_screen.dart';
import 'package:flutter_application_1/screens/listTask_screen.dart';
import 'package:flutter_application_1/screens/list_popular_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:flutter_application_1/screens/popular_movies/favorite_movies_screen.dart';
import 'package:flutter_application_1/screens/popular_movies/popular_details_screen.dart';
import 'package:flutter_application_1/screens/sign_up_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/screens/task_screen.dart';
import 'package:flutter_application_1/screens/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final int? counter = prefs.getInt('numTema');
  final int variable = counter != null ? counter : 1;
  return runApp(
    ChangeNotifierProvider(
      child: PMSNApp(),
      create: (BuildContext context) => ThemeProvider(selectedTheme: variable),
    ),
  );
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
        '/onboardingPage': (BuildContext context) => OnboardingPage(),
        '/list': (BuildContext context) => ListPopularScreen(),
        '/moviesDetail': (BuildContext context) => PopularDetailScreen(),
        '/about': (BuildContext context) => AboutUsScreen(),
        '/signup': (BuildContext context) => SignUpScreen(),
        '/favoritesMovies': (BuildContext context) => FavoritesMoviesScreen(),
        '/pokedex': (BuildContext context) => AllPokemonScreen(),
        '/detailPokemon': (BuildContext context) => DetailPokemonScreen()
      },
    );
  }
}
