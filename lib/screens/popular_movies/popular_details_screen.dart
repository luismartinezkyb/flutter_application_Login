import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/popular_mode.dart';

class PopularDetailScreen extends StatefulWidget {
  const PopularDetailScreen({Key? key}) : super(key: key);

  @override
  State<PopularDetailScreen> createState() => _PopularDetailScreenState();
}

class _PopularDetailScreenState extends State<PopularDetailScreen> {
  PopularModel? popularModel;

  @override
  Widget build(BuildContext context) {
    popularModel = ModalRoute.of(context)?.settings.arguments as PopularModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('${popularModel!.title}'),
      ),
    );
  }
}
