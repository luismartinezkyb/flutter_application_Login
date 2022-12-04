import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/theme_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_helper_photo.dart';
import '../firebase/google_authentication.dart';
import '../models/photo_model.dart';
import '../settings/styles_settings.dart';

/////***//***//***//***//***//***//
////////***//***//***//***//***//***///////***//***//***//***//***//***///////***//***//***//***//***//***//
////////***//***//***//***//***//***///////***//***//***//***//***//***///////***//***//***//***//***//***//
////////***//***//***//***//***//***///////***//***//***//***//***//***///////***//***//***//***//***//***//
////////***//***//***//***//***//***///////***//***//***//***//***//***//
class DashBoardScreen2 extends StatefulWidget {
  const DashBoardScreen2({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen2> createState() => _DashBoardScreen2State();
}

class _DashBoardScreen2State extends State<DashBoardScreen2> {
  DatabaseHelperPhoto? _database;
  String usernamePref = '';
  String pwdPref = '';
  String email = '';
  String nameUser = '';
  bool checkPhoto = true;
  int numTema = 1;
  String loggedWith = '';
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  final userFirebase = FirebaseAuth.instance.currentUser!;
  final GoogleAuthentication _googleAuth = GoogleAuthentication();
//

//METHODS SHARED ETC
//https://www.youtube.com/watch?v=PweQbVgR9iI&ab_channel=ProgrammingAddict
//https://www.youtube.com/watch?v=Ai3QWQ_1pJM&ab_channel=LazyTechNo
//to see what kind of errors the user gets
//METHODS OF SHARED PREFERENCES
  void sharedMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? users = prefs.getStringList('user');

    if (users != null) {
      setState(() {
        usernamePref = users[0];
        pwdPref = users[1];
      });
      //print('Successfully');
    }
  }

  void removeMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('user');
  }

  void logOut() {
    switch (loggedWith) {
      case 'facebook.com':
        print('Cerrando sesión de facebook');
        FacebookAuth.instance.logOut();
        FirebaseAuth.instance.signOut();
        break;
      case 'password':
        print('Cerrando sesión con email y password');
        FirebaseAuth.instance.signOut();
        break;
      case 'google.com':
        print('Cerrando sesión de google');
        _googleAuth.logout();
        FirebaseAuth.instance.signOut();
        break;
      case 'github.com':
        print('Cerrando sesión de github');
        FirebaseAuth.instance.signOut();
        break;
      default:
        FirebaseAuth.instance.signOut();
        break;
    }

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  void initState() {
    sharedMethod();
    _database = DatabaseHelperPhoto();
    super.initState();
    _checkIfLogged();
  }

  _checkIfLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

//FileImage(File(snapshot.data![0]['photoName']))
//_database

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    print('USUARIO FIREBASE: ${userFirebase}');
    //final urlAsset = 'assets/ProfilePicture.png';
    //PARA GUARDAR LA PRIMERA IMAGEN
    // photo pic = photo(0, urlAsset);
    // _database!.save(pic);
    final futuro = FutureBuilder(
      future: _database!.getPic(1),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //print('AQUI VA EL SI HAS DATA ${snapshot.data![0]['photoName']}');
          if (snapshot.data![0]['photoName'] != null) {
            //PARA CUANDO VAYAMOS INICIANDO SESIOn
            // return CircleAvatar(
            //     backgroundImage: AssetImage('assets/ProfilePicture.png'));
            return CircleAvatar(
              backgroundImage: FileImage(File(snapshot.data![0]['photoName'])),
            );
          } else {
            return CircleAvatar(
                backgroundImage: AssetImage('assets/ProfilePicture.png'));
          }
          //FileImage(File(snapshot.data![0]['photoName']))
          //print(
          //  'SI HAY UNA IMAGEN GUARDADA Y ES ${snapshot.data![0]['photoName']}');

        }
        if (snapshot.hasError) {
          print('HAY UN ERROR EN LA IMAGEN');
          return CircularProgressIndicator();
        }
        // CircleAvatar(
        //     backgroundImage: AssetImage('assets/ProfilePicture.png'),
        //   );
        return CircularProgressIndicator();
      },
    );

//METHODS OF ARGUMENTS
    // final newArguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;

    //Aqui tendriamos que hacer la comparacion sobre con que se esta logueando
    print(
        'logged with: ${FirebaseAuth.instance.currentUser!.providerData[0].providerId}');

    loggedWith = FirebaseAuth.instance.currentUser!.providerData[0].providerId;
    var checkimage = '';
    var userPhoto = '';
    switch (loggedWith) {
      case 'facebook.com':
        _userData != null
            ? userPhoto = _userData!['picture']['data']['url']
            : print('THERE is nothing');
        print('Es con Facebook el user');
        checkimage = 'assets/facebook_logo.png';
        //print(FacebookAuth.instance.accessToken.token);

        break;
      case 'password':
        checkimage = 'assets/email_logo.png';
        print('Es con Email y password el user');
        break;
      case 'google.com':
        userPhoto = userFirebase.photoURL!;
        checkimage = 'assets/google_logo.png';
        print('Es con Google el user');
        break;
      case 'github.com':
        userPhoto = userFirebase.photoURL!;
        checkimage = 'assets/github_logo.png';
        print('Es con Github el user');
        break;
      default:
        checkimage = 'assets/pokebola2.png';

        break;
    }
    nameUser = userFirebase.displayName != null
        ? userFirebase.displayName!
        : 'errorname';

    email = userFirebase.email!;
    //Lo siguiente era para saber si es que se podría utilizar el arguments y las preferencias compartidas
    // if (usernamePref == '') {
    //   if (arguments.isEmpty || arguments['username'].isEmpty) {
    //     nameUser = 'DEFAULT_USER';
    //     email = 'example@mail.com';
    //   } else {
    //     setState(() {
    //       checkPhoto = false;
    //     });
    //     nameUser = arguments['username'];
    //     email = arguments['username'].replaceAll(' ', '');
    //   }
    // } else {
    //   nameUser = usernamePref;
    //   email = usernamePref.replaceAll(' ', '') + '@gmail.com';
    // }

    Widget ColorWidgetRow() {
      return Row(
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
      );
    }

    //print('EL NOMBRE DEL USUARIO ES $nameUser');
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido ${nameUser}'),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: GestureDetector(
                  child: loggedWith == 'password'
                      ? Hero(tag: 'profile_picture', child: futuro)
                      : CircleAvatar(
                          backgroundImage: NetworkImage(userPhoto.length != 0
                              ? '$userPhoto'
                              : 'http://www.gravatar.com/avatar/?d=mp')),
                  onTap: () async {
                    if (loggedWith == 'password') {
                      final data =
                          await Navigator.pushNamed(context, '/userprofile');
                      print(data);

                      setState(() {
                        build(context);
                      });
                    }
                  }),
              accountName: Text(
                nameUser,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              accountEmail: Text(
                email,
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/gengar.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                ExpansionTile(
                  leading: Image.asset(
                    'assets/pokebola2.png',
                    width: 40,
                    height: 40,
                  ),
                  title: Text("Cambiar Tema"),
                  children: [
                    ListTile(
                      trailing: Icon(Icons.dark_mode),
                      title: Text('Dark Mode'),
                      onTap: () {
                        tema.sethemeData(temaNoche());
                      },
                    ),
                    ListTile(
                      trailing: Icon(Icons.light_mode),
                      title: Text('Ligth Mode'),
                      onTap: () {
                        tema.sethemeData(temaDia());
                      },
                    ),
                    ListTile(
                      trailing: Icon(Icons.people),
                      title: Text('Custom Mode'),
                      onTap: () {
                        tema.sethemeData(temaCalido());
                      },
                    ),
                  ],
                ),
              ],
            ),

            ListTile(
              leading: Image.asset(
                'assets/pokebola2.png',
                width: 40,
                height: 40,
              ),
              trailing: Icon(Icons.settings),
              title: Text('Base de datos'),
              onTap: () {
                Navigator.pushNamed(context, '/task');
              },
            ),

            ListTile(
              leading: Image.asset(
                'assets/pokebola2.png',
                width: 40,
                height: 40,
              ),
              trailing: Icon(Icons.movie),
              title: Text('Popular Movies'),
              onTap: () {
                Navigator.pushNamed(context, '/list');
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/pokebola2.png',
                width: 40,
                height: 40,
              ),
              trailing: Icon(Icons.star_rounded),
              title: Text('Favorite Movies'),
              onTap: () {
                Navigator.pushNamed(context, '/favoritesMovies');
              },
            ),
            ListTile(
              leading:
                  Image.asset('assets/pokebola2.png', width: 40, height: 40),
              trailing: Icon(Icons.list_alt_rounded),
              title: Text('Pokedex'),
              onTap: () {
                Navigator.pushNamed(context, '/pokedex');
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/pokebola2.png',
                width: 40,
                height: 40,
              ),
              trailing: Icon(Icons.settings),
              title: Text('About us'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ), //favoritesMovies

            ListTile(
              leading: Image.asset(
                'assets/pokebola2.png',
                width: 40,
                height: 40,
              ),
              trailing: Icon(Icons.close),
              title: Text('Log out'),
              onTap: () {
                logOut();
                //Navigator.pushNamedAndRemoveUntil(context, (route) => ModalRoute('/login'));
                //Navigator.pushNamed(context, '/login');
              },
            ),

            // ListTile(
            //   leading: Image.asset(
            //     'assets/pokebola2.png',
            //     width: 40,
            //     height: 40,
            //   ),
            //   trailing: Icon(Icons.wb_sunny_outlined),
            //   title: Text('OnboardingPage'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/onboardingPage');
            //   },
            // ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img_fondo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.white70,
            ),
            child: Column(
              children: [
                ColorWidgetRow(),
                SizedBox(height: 20),
                Text(
                  'You are logged in with :',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                checkimage.length != 0
                    ? Image.asset(
                        checkimage,
                        width: 50,
                      )
                    : Image.asset(
                        'assets/pokebola2.png',
                        width: 50,
                      ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    removeMethod();
                    logOut();
                  },
                  child: Text(
                    'EMERGENCY LOG OUT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//User(displayName: Luis Martinez, email: luisramonmartinezarredondo08@gmail.com, emailVerified: false, isAnonymous: false, metadata: UserMetadata(creationTime: 2022-11-07 23:31:41.465Z, lastSignInTime: 2022-11-08 00:14:23.659Z), phoneNumber: null, photoURL: https://graph.facebook.com/2460536054084767/picture, providerData, [UserInfo(displayName: Luis Martinez, email: luisramonmartinezarredondo08@gmail.com, phoneNumber: null, photoURL: https://graph.facebook.com/2460536054084767/picture, providerId: facebook.com, uid: 2460536054084767)], refreshToken: , tenantId: null, uid: TkzXqsqkJMOWGksr7uy3m0g2hvM2)
