import 'package:flutter/material.dart';
import 'package:quiz/model/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question _question;

  const QuestionWidget(this._question, {Key key}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final correctColor = Colors.green;
  final wrongColor = Colors.red;
  var color = Colors.purple;
  var colors = [];
  List<String> options = [];
  var correctAnswerIndex = 0;
  var answered = false;

  @override
  void initState() {
    super.initState();
    options = widget._question.options;
    for (int i = 0; i < options.length; ++i) {
      colors.add(color);

      if (options[i] == widget._question.correctAnswer) {
        correctAnswerIndex = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget questionContainer(String question) => Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: 24),
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
          padding:
              EdgeInsets.only(bottom: index == options.length - 1 ? 0 : 16),
          child: Material(
            elevation: 10,
            color: colors[index],
            child: MaterialButton(
              onPressed: answered
                  ? null
                  : () {
                      setState(() {
                        colors[index] = wrongColor;
                        colors[correctAnswerIndex] = correctColor;
                        answered = true;
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
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        );

    List<Widget> optionWidgets = [];

    for (int i = 0; i < options.length; ++i) {
      String option = options[i];
      var temp = option == widget._question.correctAnswer
          ? optionWidget(i, option, isCorrect: true)
          : optionWidget(i, option);
      optionWidgets.add(temp);
    }

    return Material(
      child: Container(
        child: Column(
          children:
              [questionContainer(widget._question.question)] + optionWidgets,
        ),
      ),
    );
  }
}
