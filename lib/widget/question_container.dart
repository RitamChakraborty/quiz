import 'package:flutter/material.dart';
import 'package:quiz/model/question.dart';

class QuestionContainer extends StatefulWidget {
  @override
  _QuestionContainerState createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer> {
  final correctColor = Colors.green;
  final wrongColor = Colors.red;
  var color = Colors.purple;
  var colors = [];
  final Question question = Question(
    type: "any",
    difficulty: "any",
    category: "any",
    correctAnswer: "correct",
    incorrectAnswers: ["incorrect1", "incorrect2", "incorrect3"],
    question: "This is a question for which no answer exists!",
  );
  List<String> options = [];
  var correctAnswerIndex = 0;

  @override
  void initState() {
    super.initState();
    options = question.options;
    for (int i = 0; i < options.length; ++i) {
      colors.add(color);

      if (options[i] == question.correctAnswer) {
        correctAnswerIndex = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

    Widget optionWidget(int index, String option, {bool isCorrect = false}) =>
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Material(
            elevation: 10,
            color: colors[index],
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  colors[index] = wrongColor;
                  colors[correctAnswerIndex] = correctColor;
                });
              },
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

    List<Widget> optionWidgets = [];

    for (int i = 0; i < options.length; ++i) {
      String option = options[i];
      var widget = option == question.correctAnswer
          ? optionWidget(i, option, isCorrect: true)
          : optionWidget(i, option);
      optionWidgets.add(widget);
    }

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
