import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_helper_photo.dart';
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
//METHODS SHARED ETC
//METHODS OF SHARED PREFERENCES
  void sharedMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? users = prefs.getStringList('user');

    if (users != null) {
      setState(() {
        usernamePref = users[0];
        pwdPref = users[1];
      });
      print('Successfully');
    }
  }

  void removeMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('user');
  }

  @override
  void initState() {
    sharedMethod();
    _database = DatabaseHelperPhoto();
    super.initState();
  }

//FileImage(File(snapshot.data![0]['photoName']))
//_database

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    final urlAsset = 'assets/ProfilePicture.png';
    //PARA GUARDAR LA PRIMERA IMAGEN
    // photo pic = photo(0, urlAsset);
    // _database!.save(pic);
    final futuro = FutureBuilder(
      future: _database!.getPic(1),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          print('AQUI VA EL SI HAS DATA ${snapshot.data![0]['photoName']}');
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
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    if (usernamePref == '') {
      if (arguments.isEmpty || arguments['username'].isEmpty) {
        nameUser = 'DEFAULT_USER';
        email = 'example@mail.com';
      } else {
        setState(() {
          checkPhoto = false;
        });
        nameUser = arguments['username'];
        email = arguments['username'].replaceAll(' ', '') + '@gmail.com';
      }
    } else {
      nameUser = usernamePref;
      email = usernamePref.replaceAll(' ', '') + '@gmail.com';
    }

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
                  child: Hero(tag: 'profile_picture', child: futuro),
                  onTap: () async {
                    final data =
                        await Navigator.pushNamed(context, '/userprofile');
                    print(data);

                    setState(() {
                      build(context);
                    });
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
                removeMethod();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
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
                ElevatedButton(
                  onPressed: () {
                    removeMethod();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img_fondo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
