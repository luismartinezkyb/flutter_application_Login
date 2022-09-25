import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    super.initState();
  }

  Widget newFoto() {
    if (usernamePref == '' && checkPhoto) {
      return CircleAvatar(
        backgroundColor: Colors.white38,
        child: Text('US'),
      );
      //}
    }
    return Hero(
      tag: 'profile_picture',
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/ProfilePicture.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: newFoto(),
                  onTap: () {
                    Navigator.pushNamed(context, '/userprofile');
                    print("hey");
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
                print('hola');
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
            )
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
