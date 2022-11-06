import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../firebase/email_authentication.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNick = TextEditingController();
  TextEditingController txtMail = TextEditingController();
  TextEditingController txtPwd = TextEditingController();
  EmailAuthentication? _emailAuth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailAuth = EmailAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuarios'),
      ),
      body: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'No registrado');
                      },
                      child: Icon(Icons.close),
                    ),
                    GestureDetector(
                      onTap: () {
                        print(
                            'pulsado with: ${txtMail.text} ${txtPwd.text} ${txtName.text}');
                        if (txtMail.text.length != 0 &&
                            txtPwd.text.length >= 7 &&
                            txtName.text.length != 0) {
                          _emailAuth!
                              .createUserWithEmailAndPassword(
                                  email: txtMail.text,
                                  password: txtPwd.text,
                                  name: txtName.text)
                              .then((value) {
                            Navigator.pop(context, 'usuario Registrado');
                            print(value);
                          });
                        } else {
                          print(
                              'Debes de cumplir con las reglas, poner datos correctos, etc');
                        }
                      },
                      child: Text(
                        'Guardar Perfil',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Swiss',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: txtName,
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                  ),
                ),
                TextFormField(
                  controller: txtMail,
                  decoration: InputDecoration(
                    hintText: 'Correo',
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: txtPwd,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                  ),
                ),
              ],
            ),
            //color: Colors.white,
          ),
        ),
      ),
    );
  }
}
