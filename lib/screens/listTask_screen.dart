import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';

import '../models/tasks_model.dart';

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
        builder: (context, AsyncSnapshot<List<TasksDAO>> snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      height: MediaQuery.of(context).size.height * .15,
                      width: double.infinity,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(snapshot.data![index].fechaEntrega!),
                            subtitle: Text(snapshot.data![index].dscTask!),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: null, icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Importante!!'),
                                            content: Text(
                                                '¿Desea borrar esta tarea?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _database!.deleteTask(
                                                          snapshot.data![index]
                                                              .idTask!,
                                                          'tblTasks');
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Aceptar')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancelar')),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red[100],
                      ));
                },
                itemCount: snapshot.data!.length);
          else if (snapshot.hasError)
            return Center(child: Text('Occurio un errror en la peticion...'));
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
