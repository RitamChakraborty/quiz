import 'package:flutter/material.dart';
import 'package:quiz/model/Result.dart';

class ScorePage extends StatelessWidget {
  static const routeName = "/scorePage";

  @override
  Widget build(BuildContext context) {
    final Result result = ModalRoute.of(context).settings.arguments as Result;

    return Material(
      child: Container(
        child: Center(
          child: Text("${result.marksObtained}/${result.totalMarks}"),
        ),
      ),
    );
  }
}
