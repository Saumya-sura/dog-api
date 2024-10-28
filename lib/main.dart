import 'package:dog/list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('savedDogs'); 
  runApp(DogExplorerApp());
}

class DogExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Explorer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Listing()
    );
  }
}
