import 'package:flutter/material.dart';
import 'package:quiz/model/Result.dart';
import 'package:quiz/view/home_page.dart';

class ScorePage extends StatelessWidget {
  static const routeName = "/scorePage";

  @override
  Widget build(BuildContext context) {
    final Result result = ModalRoute.of(context).settings.arguments as Result;

    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(HomePage.routeName);
        },
        child: Container(
          child: Center(
            child: Text("${result.marksObtained}/${result.totalMarks}"),
          ),
        ),
      ),
    );
  }
}
