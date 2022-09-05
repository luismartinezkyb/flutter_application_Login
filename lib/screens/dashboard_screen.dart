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

    if (arguments['username'] == 'DEFAULT_USER') {
      print("HEEEEEEYOOO HEEEELLLLL");
    }

    //final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(159, 68, 147, 1),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/89945446?s=400&u=40d485d0893e497a977d3bd6b156a15c41e8ab06&v=4'),
              ),
              accountName: Text(
                arguments['username'],
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              accountEmail: Text(
                'luismartinezjpg@gmail.com',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/gengar.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ListTile(
              leading: Image.asset('assets/pokebola2.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar Sesión'),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset('assets/pokebola2.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar Sesión'),
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
    );
  }
}
