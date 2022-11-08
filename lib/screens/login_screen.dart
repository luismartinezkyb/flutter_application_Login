import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../firebase/email_authentication.dart';
import '../firebase/google_authentication.dart';
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
  var loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _loginWithFacebook() async {
    setState(() {
      loading = true;
    });
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      await FirebaseFirestore.instance.collection('users').add({
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name'],
      });
      if (mounted) {
        Navigator.pushNamed(context, '/onboardingPage');
      }

      // final userDoc =
      //     FirebaseFirestore.instance.collection('users').doc('my-id');

      // final json = {
      //   'email': userData['email'],
      //   'imageUrl': userData['picture']['data']['url'],
      //   'name': userData['name'],
      // };

      // await userDoc.set(json);

    } on FirebaseAuthException catch (e) {
      var title = '';
      print('ERROR EN: $e');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailAuthentication _emailAuth = EmailAuthentication();
  final GoogleAuthentication _googleAuth = GoogleAuthentication();
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
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  //this is the pokemon Logo
                  Positioned(
                    top: MediaQuery.of(context).size.width / 7,
                    child: Image.asset(
                      'assets/pokemonLogo.png',
                      width: MediaQuery.of(context).size.width / 1,
                    ),
                  ),
                  //the Container with the list view
                  Positioned(
                    //top: MediaQuery.of(context).size.height / 3.4,
                    top: MediaQuery.of(context).size.height / 4,
                    child: Container(
                        child: ListView(
                          children: [
                            Text(
                              'Sign In with Email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            txtUser,
                            SizedBox(height: 10),
                            txtPwd,
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Save your session: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
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
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'If you do not have an account please ',
                                  style: TextStyle(fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text('Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 15)),
                                )
                              ],
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 20,
                          bottom: MediaQuery.of(context).size.width / 25,
                          right: MediaQuery.of(context).size.width / 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Theme.of(context).backgroundColor,
                        ),
                        width: MediaQuery.of(context).size.width * .9,
                        height: MediaQuery.of(context).size.height / 2.7),
                  ),
                  Positioned(
                    // bottom: MediaQuery.of(context).size.width / 2.5,
                    // right: MediaQuery.of(context).size.width / 3,
                    bottom: MediaQuery.of(context).size.height / 4.1,
                    child: GestureDetector(
                      onTap: () async {
                        print('NEW SWITCH $newSwitch');
                        if (newSwitch) {
                          sharedMethod();
                        } else {
                          removeMethod();
                        }
                        var ban = await _emailAuth.signInWithEmailAndPassword(
                            email: txtConUser.text, password: txtConPwd.text);
                        if (ban == true) {
                          if (_auth.currentUser!.emailVerified) {
                            Navigator.pushNamed(context, '/onboardingPage');
                          } else
                            print('Usuario no validado');
                        } else {
                          print('Credenciales invalidas');
                        }
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
                          onPressed: () {
                            _loginWithFacebook();
                            //Navigator.pushNamed(context, '/facebook_login');
                          },
                        ),
                        SizedBox(height: 5),
                        SocialLoginButton(
                          buttonType: SocialLoginButtonType.github,
                          onPressed: () {},
                        ),
                        SizedBox(height: 5),
                        SocialLoginButton(
                          buttonType: SocialLoginButtonType.google,
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            var googleLogin = await _googleAuth.googleLogin();

                            if (googleLogin == true) {
                              Navigator.pushNamed(context, '/onboardingPage');
                            } else {
                              print('Credenciales invalidas');
                            }
                          },
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
