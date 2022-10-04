import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/database/database_helper_user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../database/database_helper_photo.dart';
import '../models/photo_model.dart';
import '../models/users_model.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  DatabaseHelperPhoto? _databasePhoto;
  DatabaseHelperUser? _databaseUser;

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
        _databasePhoto!.updatePhoto(pic).then((value) => {
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

  late SimpleDialog _sb;

  void dialogMethod() {
    _sb = SimpleDialog(
      title: Text('Elige una nueva Foto'),
      children: [
        SimpleDialogOption(
          child: Text('Elegir de Galeria'),
          onPressed: () {
            getImage(ImageSource.gallery);
            Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          child: Text('Tomar Foto'),
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

  @override
  void initState() {
    _databasePhoto = DatabaseHelperPhoto();
    _databaseUser = DatabaseHelperUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _txtName = TextEditingController();
    final TextEditingController _txtEmail = TextEditingController();
    final TextEditingController _txtPhone = TextEditingController();
    final TextEditingController _txtGithubPage = TextEditingController();
    final futuro = FutureBuilder(
      future: _databasePhoto!.getPic(1),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () async {
              dialogMethod();
            },
            child: Image.file(
              File(snapshot.data![0]['photoName']),
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),
          );
        }
        if (snapshot.hasError) {
          return Ink.image(
            image: AssetImage('assets/ProfilePicture.png'),
            fit: BoxFit.cover,
            width: 120,
            height: 120,
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

    //ARGUMENTS
    final argumentsTask = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (argumentsTask.isEmpty) {
      print('Vaciossss');
    } else {
      setState(() {
        _txtName.text = argumentsTask['userName'];
        _txtEmail.text = argumentsTask['emailUser'];
        _txtPhone.text = argumentsTask['phoneUser'];
        _txtGithubPage.text = argumentsTask['githubUser'];
      });
    }
    final tfName = TextField(
      controller: _txtName,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    final tfEmail = TextField(
      controller: _txtEmail,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    final tfPhone = TextField(
      controller: _txtPhone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
    final tfGithubPage = TextField(
      controller: _txtGithubPage,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context, 'newData');
          },
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text('Editting User Info'),
        actions: [],
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
          SizedBox(height: 30),
          // TextFieldWidget(
          //   label: 'Nombre Completo',
          //   text: 'Luis Martinez'
          //   onChanged: (name){

          //   }
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                tfName
              ],
            ),
          ),
          //TextFieldWidget('Full Name'),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                tfEmail
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                tfPhone
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Github Page',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                tfGithubPage
              ],
            ),
          ),
          SizedBox(height: 28),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: Size(MediaQuery.of(context).size.width / 2,
                      MediaQuery.of(context).size.height / 15),
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shadowColor: Colors.black),
              onPressed: () {
                //HERE Is the code for back to the user profile
                UserModel newUser = UserModel(0, _txtName.text, _txtEmail.text,
                    _txtPhone.text, _txtGithubPage.text);
                _databaseUser!.updateUser(newUser).then((value) => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Usuario Actualizado Exitosamente'),
                        ),
                      ),
                    });
                print(_txtName.text);
                print(_txtPhone.text);
                print(_txtEmail.text);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/userprofile', (route) => false);
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  Widget TextFieldWidget(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
            Icons.edit,
            size: 15,
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
