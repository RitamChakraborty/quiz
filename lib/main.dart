import 'package:flutter/material.dart';
import 'package:quiz/v2/view/customize_quiz_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.grey,
        backgroundColor: Colors.grey[200],
      ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   backgroundColor: Colors.grey[800],
      //   buttonColor: Colors.grey,
      // ),
      home: CustomizeQuizPage(),
    );
  }
}
