import 'package:flutter/material.dart';
import 'package:quiz/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz",
      home: HomePage(),
    );
  }
}
