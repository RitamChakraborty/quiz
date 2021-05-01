import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/v2/mode/question.dart';
import 'package:quiz/v2/mode/question_parameter.dart';
import 'package:quiz/v2/service/question_service_provider.dart';

class QuizPage extends StatelessWidget {
  static Route<dynamic> route(QuizParameter quizParameter) =>
      MaterialPageRoute(builder: (_) => QuizPage(quizParameter));

  final QuizParameter _quizParameter;

  const QuizPage(this._quizParameter);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionServiceProvider>(
      create: (_) => QuestionServiceProvider(),
      builder: (context, child) {
        QuestionServiceProvider questionService =
            Provider.of<QuestionServiceProvider>(context);
        List<Question> questions = questionService.questions;

        if (questions == null) {
          questionService.fetchQuestion(_quizParameter);
        }

        return Material(
          child: Container(
            child: Center(
              child: Text(_quizParameter.amount.toString()),
            ),
          ),
        );
      },
    );
  }
}
