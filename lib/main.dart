
import 'package:firebase_json/features/sample_fire/blog/blog.dart';
import 'package:firebase_json/features/sample_fire/sample_fire_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Blog(),
    );
  }
}
