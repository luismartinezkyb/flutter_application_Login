import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_helper_photo.dart';

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
    final futuro = FutureBuilder(
      future: _database!.getPic(1),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //FileImage(File(snapshot.data![0]['photoName']))
          print(
              'SI HAY UNA IMAGEN GUARDADA Y ES ${snapshot.data![0]['photoName']}');
          return CircleAvatar(
            backgroundImage: FileImage(File(snapshot.data![0]['photoName'])),
          );
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
            ListTile(
              leading: Image.asset('assets/pokebola2.png'),
              trailing: Icon(Icons.settings),
              title: Text('Base de datos'),
              onTap: () {
                Navigator.pushNamed(context, '/task');
              },
            ),
            ListTile(
              leading: Image.asset('assets/pokebola2.png'),
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
            ListTile(
              leading: Image.asset('assets/pokebola2.png'),
              trailing: Icon(Icons.star_border_sharp),
              title: Text('OnboardingPage'),
              onTap: () {
                Navigator.pushNamed(context, '/onboardingPage');
              },
            ),
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
                ThemeScreeen(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    removeMethod();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                  child: Text('EMERGENCY LOG OUT'),
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
