import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/database/database_helper.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DatabaseHelper? _database;

  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtFechaTask = TextEditingController();
    TextEditingController txtDescTask = TextEditingController();
    final tfFecha = TextField(
      controller: txtFechaTask,
      maxLines: 2,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
    final tfDescTask = TextField(
      decoration: InputDecoration(border: OutlineInputBorder()),
      controller: txtDescTask,
    );
    final btnSave = ElevatedButton(
      onPressed: () {
        _database!.insertTask({
          'dscTask': txtDescTask.text,
          'fechaEntrega': txtFechaTask.text,
        }, 'tblTasks').then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Insert completed'),
              ))
            });
        Navigator.pushNamedAndRemoveUntil(context, '/task', (route) => false);
      },
      child: Text('Save'),
    );

    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
        children: [
          tfFecha,
          SizedBox(height: 10),
          tfDescTask,
          SizedBox(height: 10),
          btnSave,
        ],
      ),
    );
  }
}
