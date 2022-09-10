import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';

class ListTaskScreen extends StatefulWidget {
  const ListTaskScreen({Key? key}) : super(key: key);

  @override
  State<ListTaskScreen> createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  DatabaseHelper? _database;

  @override
  void initState() {
    _database = DatabaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Task'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addTask');
              },
              icon: Icon(Icons.add_circle_outline)),
        ],
      ),
      body: FutureBuilder(
        future: _database!.getAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Center(child: Text('The content is here'));
          else if (snapshot.hasError)
            return Center(child: Text('Occurio un errror en la peticion...'));
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
