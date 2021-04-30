import 'package:flutter/material.dart';
import 'package:quiz/v2/mode/question_parameter.dart';

class QuizPage extends StatelessWidget {
  static Route<dynamic> route(QuizParameter quizParameter) =>
      MaterialPageRoute(builder: (_) => QuizPage(quizParameter));

  final QuizParameter _quizParameter;

  const QuizPage(this._quizParameter);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: Text(_quizParameter.amount.toString()),
        ),
      ),
    );
  }
}
