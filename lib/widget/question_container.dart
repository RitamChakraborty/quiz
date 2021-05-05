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

    Widget questionContainer(String question) => Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Material(
              elevation: 10,
              color: Colors.deepPurple,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  question,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),
          ),
        );

    Widget optionWidget(String option) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Material(
            elevation: 10,
            color: Colors.deepPurple,
            child: MaterialButton(
              onPressed: () {},
              child: AnimatedContainer(
                margin: const EdgeInsets.all(16),
                alignment: Alignment.center,
                duration: Duration(milliseconds: 400),
                child: Text(
                  option,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );

    List<Widget> optionWidgets =
        question.options.map((option) => optionWidget(option)).toList();

    return Material(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [questionContainer(question.question)] + optionWidgets,
        ),
      ),
    );
  }
}
