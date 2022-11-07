import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class FacebookLoginScreen extends StatefulWidget {
  const FacebookLoginScreen({Key? key}) : super(key: key);

  @override
  State<FacebookLoginScreen> createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(int.parse('0xFF3b5998')),
        body: Stack(children: [
          Positioned(
            top: 50,
            left: 5,
            child: IconButton(
              iconSize: 30,
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context, 'newData');
              },
            ),
          ),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Ink.image(
                    image: AssetImage('assets/facebook_logo.png'),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 26),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(children: [
                      Text(
                        'Aqui ira el email',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Aqui ira la pass',
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        )),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
