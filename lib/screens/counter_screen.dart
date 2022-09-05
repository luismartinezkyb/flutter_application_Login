import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contador = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stateless vs StateFul',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Text(
        'Contador $contador',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contador++;
          print(contador);
          //setState(() {});
        },
        child: Icon(
          Icons.ads_click,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
