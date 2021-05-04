import 'package:flutter/material.dart';
import 'package:quiz/model/question.dart';

class QuestionContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Question question = Question(
      type: "any",
      difficulty: "any",
      category: "any",
      correctAnswer: "correct",
      incorrectAnswers: ["incorrect1", "incorrect2", "incorrect3"],
      question: "This is a question for which no answer exists!",
    );

    Widget questionContainer(String question) => Container(
          child: Card(
            elevation: 10,
            child: Container(
              alignment: Alignment.center,
              child: Text(question),
            ),
          ),
        );

    Widget optionWidget(String option) => Container(
          child: Card(
            child: Container(
              alignment: Alignment.center,
              child: Text(option),
            ),
          ),
        );

    List<Widget> optionWidgets =
        question.options.map((option) => optionWidget(option)).toList();

    return Material(
      child: Column(
        children: [questionContainer(question.question)] + optionWidgets,
      ),
    );
  }
}
