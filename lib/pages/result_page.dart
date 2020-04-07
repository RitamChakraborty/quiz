import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int marks;

  const ResultPage({this.score, this.marks});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Text("$score/$marks"),
          ),
        ),
      ),
    );
  }
}
