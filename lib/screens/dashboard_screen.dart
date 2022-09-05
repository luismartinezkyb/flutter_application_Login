import 'package:flutter/material.dart';

class ScreenArguments {
  final String v1;

  ScreenArguments(this.v1);
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    String email = '';

    Widget newFoto() {
      if (arguments['username'] == 'DEFAULT_USER') {
        return CircleAvatar(
          backgroundColor: Colors.white38,
          child: Text('US'),
        );
      }
      return CircleAvatar(
        backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/89945446?s=400&u=40d485d0893e497a977d3bd6b156a15c41e8ab06&v=4'),
      );
    }

    if (arguments['username'] == 'DEFAULT_USER') {
      email = 'example@mail.com';
      print("HEEEEEEYOOO HEEEELLLLL");
    } else {
      email = arguments['username'].replaceAll(' ', '') + '@gmail.com';
    }

    //final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido ${arguments['username']}'),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer(
        backgroundColor: Colors.lightBlue,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: newFoto(),
              accountName: Text(
                arguments['username'],
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
