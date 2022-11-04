import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/database/database_helper_photo.dart';

import 'package:flutter_application_1/models/photo_model.dart';
import 'package:flutter_application_1/models/users_model.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../database/database_helper_user.dart';
import '../settings/styles_settings.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  DatabaseHelperPhoto? _database;
  DatabaseHelperUser? _database2;

  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);

      //final imagePermament = await saveFilePerma(image.path);

      setState(() {
        this._image = imageTemporary;
        //print('EL PATH DE LA IMAGEN TEMPRAL ES: ${imageTemporary.path}');
        photo pic = photo(0, imageTemporary.path);
        _database!.updatePhoto(pic).then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Imagen Actualizada Exitosamente!'),
                ),
              ),
            });
        //imagePermament
      });
      //print(_image);
    } on PlatformException catch (e) {
      print('Failed to pick the image : $e');
    }
  }

  @override
  void initState() {
    _database = DatabaseHelperPhoto();
    _database2 = DatabaseHelperUser();
    super.initState();
  }

  late SimpleDialog _sb;

  void dialogMethod() {
    _sb = SimpleDialog(
      title: Text(
        'Elige una nueva Foto',
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
      children: [
        SimpleDialogOption(
          child: ListTile(
            title: Text(
              'Elegir una imagen',
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            trailing: Icon(
              Icons.folder,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          onPressed: () {
            getImage(ImageSource.gallery);
            Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          child: ListTile(
            title: Text(
              'Tomar Foto',
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            trailing: Icon(
              Icons.camera_alt,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          onPressed: () {
            getImage(ImageSource.camera);
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _sb;
        });
  }

  late String imageUsuario = "";
  late String nombreUsuario = "";
  late String correoUsuario = "";
  late String telefonoUsuario = "";
  late String gitUsuario = "";

  bool verifyTheme = false;
  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context, listen: false);
    final urlAsset = 'assets/ProfilePicture.png';
    //PARA GUARDAR LA PRIMERA IMAGEN
    // photo pic = photo(0, urlAsset);
    // _database!.save(pic);
    // UserModel newUser = UserModel(0, 'Luis Martinez', 'luismartinez@gmail.com',
    //     '4612091668', 'https://github.com/luismartinezkyb');
    // _database2!.save(newUser);

    final futuro2 = FutureBuilder(
      future: _database2!.getUser(),
      builder: (context, AsyncSnapshot<List> snapshot2) {
        if (snapshot2.hasData) {
          nombreUsuario = snapshot2.data![0]['nameUser'];
          correoUsuario = snapshot2.data![0]['emailUser'];
          telefonoUsuario = snapshot2.data![0]['phoneUser'];
          gitUsuario = snapshot2.data![0]['githubUser'];
          // print(
          //     'Name user: $nombreUsuario, Email $correoUsuario, Phone: $telefonoUsuario');
          return Column(
            children: [
              SizedBox(height: 24),
              buildName(nombreUsuario, correoUsuario),
              SizedBox(height: 38),
              buildInfo(telefonoUsuario, gitUsuario),
              SizedBox(height: 48),
            ],
          );
        }
        if (snapshot2.hasError) {
          nombreUsuario = "null";
          correoUsuario = "null";
          telefonoUsuario = "null";
          gitUsuario = "null";
          return CircularProgressIndicator();
        }
        return CircularProgressIndicator();
      },
    );

    final futuro = FutureBuilder(
      future: _database!.getPic(1),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          //primero comentamos el futuro 2 y luego agregamos las lineas de arriba, aqui podriamos crear un
          //gesture detector con un Image.asset y un string como el del dashboard
          print(
              'Checamos que es lo que tiene ${snapshot.data![0]['photoName']}');

          imageUsuario = snapshot.data![0]['photoName'];
          print('el path ess $imageUsuario');
          return GestureDetector(
            onTap: () async {
              dialogMethod();
            },
            child: Image.file(
              File(snapshot.data![0]['photoName']),
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
          );
        }
        if (snapshot.hasError) {
          return Ink.image(
            image: AssetImage('assets/ProfilePicture.png'),
            fit: BoxFit.cover,
            width: 200,
            height: 200,
            child: InkWell(
              onTap: () async {
                dialogMethod();
              },
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );

//

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            // Navigator.popUntil(context, (route) => false)
            // Navigator.pop(context, 'newData');
            Navigator.pushNamedAndRemoveUntil(
                context, '/dash', (route) => false);
          },
        ),
        title: Text('User Profile'),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                verifyTheme = !verifyTheme;
              });
              if (verifyTheme) {
                tema.sethemeData(temaNoche());
              } else {
                tema.sethemeData(temaDia());
              }
            },
            icon: Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 10,
          ),
          ProfileWidget(
            imagePath: Hero(
              tag: 'profile_picture',
              child: ClipOval(
                child: Material(color: Colors.transparent, child: futuro),
              ),
            ),
            onClicked: () async {
              dialogMethod();
            },
          ),
          futuro2,
          Center(child: buildEditButton()),
        ],
      ),
    );
  }
//tengo que activar el boton para saber por que tengo mal la bd

  Widget buildName(String user, String email) => Column(
        children: [
          Text(
            user,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 10),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildInfo(String numero, String github) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Phone',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(numero),
            SizedBox(
              height: 40,
            ),
            Text(
              'GitHub Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(github)
          ],
        ),
      );

  Widget buildEditButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).backgroundColor,
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shadowColor: Colors.black),
        onPressed: () async {
          final data = await Navigator.pushNamed(context, '/editProfilePage',
              arguments: {
                "imageUser": imageUsuario,
                "userName": nombreUsuario,
                "emailUser": correoUsuario,
                "phoneUser": telefonoUsuario,
                "githubUser": gitUsuario,
              });
          print(data);
          setState(() {
            build(context);
          });
        },
        child: Text('Edit your profile'),
      );
}

//armamos el widget del perfil completo
class ProfileWidget extends StatelessWidget {
  final Widget imagePath;
  final VoidCallback onClicked;

  const ProfileWidget(
      {Key? key, required this.imagePath, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).backgroundColor;
    return Center(
      child: Stack(
        children: [
          imagePath,
          Positioned(
            bottom: 0,
            right: 4,
            child:
                GestureDetector(onTap: onClicked, child: buildEditIcon(color)),
          ),
        ],
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 10,
          child: Icon(
            color: Colors.white,
            Icons.camera_alt,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
