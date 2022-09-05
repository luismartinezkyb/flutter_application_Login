import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String usernamePref = '';
    String pwdPref = '';
//METHODS OF SHARED PREFERENCES
    void sharedMethod() async {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? users = prefs.getStringList('user');

      if (users != null) {
        usernamePref = users[0];
        pwdPref = users[1];
      }
      print("USER DASH $users");
    }

    void removeMethod() async {
      final prefs = await SharedPreferences.getInstance();
      final success = await prefs.remove('user');
    }

//METHODS OF ARGUMENTS
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    String email = '';
    String nameUser = '';

    Widget newFoto() {
      if (usernamePref == '') {
        if (arguments.isEmpty || arguments['username'] == 'DEFAULT_USER') {
          return CircleAvatar(
            backgroundColor: Colors.white38,
            child: Text('US'),
          );
        }
      }
      return CircleAvatar(
        backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/89945446?s=400&u=40d485d0893e497a977d3bd6b156a15c41e8ab06&v=4'),
      );
    }

    if (usernamePref == '') {
      if (arguments.isEmpty || arguments['username'] == 'DEFAULT_USER') {
        nameUser = 'DEFAULT_USER';
        email = 'example@mail.com';
        print("HEEEEEEYOOO HEEEELLLLL");
      } else {
        email = arguments['username'].replaceAll(' ', '') + '@gmail.com';
      }
    } else {
      nameUser = usernamePref;
      email = usernamePref.replaceAll(' ', '') + '@gmail.com';
    }

    //final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido ${nameUser}'),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer(
        backgroundColor: Colors.lightBlue,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: newFoto(),
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
              title: Text('Settings'),
              onTap: () {},
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
        decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            image: AssetImage('assets/img_fondo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

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
    return CircleAvatar(
      backgroundImage: NetworkImage(
          'https://avatars.githubusercontent.com/u/89945446?s=400&u=40d485d0893e497a977d3bd6b156a15c41e8ab06&v=4'),
    );
  }

  @override
  Widget build(BuildContext context) {
//METHODS OF ARGUMENTS
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    //if (arguments.isEmpty || arguments['username'] == 'DEFAULT_USER') {
    //} else {
    //email = arguments['username'].replaceAll(' ', '') + '@gmail.com';
    //}

    //if (arguments.isEmpty || arguments['username'] == 'DEFAULT_USER') {
    if (usernamePref == '') {
      print('ARGUMENTosS $arguments');
      if (arguments.isEmpty || arguments['username'].isEmpty) {
        nameUser = 'DEFAULT_USER';
        email = 'example@mail.com';
        print("HEEEEEEYOOO HEEEELLLLL");
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
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer(
        backgroundColor: Colors.lightBlue,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: newFoto(),
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
              title: Text('Settings'),
              onTap: () {},
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
        decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            image: AssetImage('assets/img_fondo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
