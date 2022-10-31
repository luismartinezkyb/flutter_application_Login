import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
//import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  //const LoginScreen({super.key});
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //this is to start form validation but is not required
  //final _formKey = GlobalKey<FormState>();

  //to initializate the sharedMethod
  void sharedMethod() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .setStringList('user', <String>[txtConUser.text, txtConPwd.text]);
    //final List<String>? users = prefs.getStringList('user');
  }

  //to remove the user shared preferences if exists
  void removeMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('user');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool newSwitch = false;
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      controller: txtConUser,
      decoration:
          InputDecoration(hintText: 'Enter the user', label: Text('Email')),
    );
    final txtPwd = TextField(
      controller: txtConPwd,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Enter the password', label: Text('Password')),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pokemon_fondo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 7,
              child: Image.asset(
                'assets/pokemonLogo.png',
                width: MediaQuery.of(context).size.width / 1,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                bottom: MediaQuery.of(context).size.width / 25,
                right: MediaQuery.of(context).size.width / 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.white,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'User Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  txtUser,
                  SizedBox(height: 10),
                  txtPwd,
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Save your session: '),
                      Switch(
                          value: newSwitch,
                          onChanged: (val) {
                            print(val);
                            setState(() {
                              newSwitch = !newSwitch;
                            });
                            // method1('The switch value is $checkBool');
                          })
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              // bottom: MediaQuery.of(context).size.width / 2.5,
              // right: MediaQuery.of(context).size.width / 3,
              bottom: MediaQuery.of(context).size.height / 4.1,
              child: GestureDetector(
                onTap: () {
                  print(newSwitch);
                  if (newSwitch) {
                    sharedMethod();
                  } else {
                    removeMethod();
                  }
                  // setState(() {
                  //   txtConUser.text.isEmpty
                  //       ? txtConUser.text = 'DEFAULT_USER'
                  //       : '';
                  // });
                  Navigator.pushNamed(context, '/onboardingPage', arguments: {
                    "username": txtConUser.text,
                    "password": txtConPwd.text
                  });
                  //MaterialPageRoute(builder: (context) {}));
                },
                child: Image.asset(
                  'assets/pokeball11.png',
                  height: MediaQuery.of(context).size.width / 6,
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 15,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20),
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.facebook,
                    onPressed: () {},
                  ),
                  SizedBox(height: 5),
                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.github,
                    onPressed: () {},
                  ),
                  SizedBox(height: 5),
                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.apple,
                    onPressed: () {},
                  ),
                ]),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 1.8,
              child: TextButton(
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pushNamed(context, '/signup'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
