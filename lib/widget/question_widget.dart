import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz/model/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question _question;

  const QuestionWidget({@required Question question, Key key})
      : this._question = question,
        assert(question != null),
        super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  List<String> options;
  List<Widget> optionWidgets;
  List<Color> colors;
  final color = Colors.purple;
  final correctColor = Colors.green;
  final wrongColor = Colors.red;
  var correctAnswerIndex;
  var answered;

  @override
  void initState() {
    super.initState();

    options = widget._question.options;
    optionWidgets = [];
    colors = [];
    correctAnswerIndex = 0;
    answered = false;

    for (int i = 0; i < options.length; ++i) {
      colors.add(color);

      if (options[i] == widget._question.correctAnswer) {
        correctAnswerIndex = i;
      }
    }
  }

  @override
  void didUpdateWidget(QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    options = widget._question.options;
    optionWidgets = [];
    colors = [];
    correctAnswerIndex = 0;
    answered = false;

    for (int i = 0; i < options.length; ++i) {
      colors.add(color);

      if (options[i] == widget._question.correctAnswer) {
        correctAnswerIndex = i;
      }
    }
  }

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
        padding: EdgeInsets.only(bottom: index == options.length - 1 ? 0 : 16),
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

  @override
  Widget build(BuildContext context) {
    optionWidgets = List.generate(options.length, (i) {
      String option = options[i];
      return option == widget._question.correctAnswer
          ? optionWidget(i, option, isCorrect: true)
          : optionWidget(i, option);
    });

    return Material(
      child: Container(
        child: Column(
          children: [
                questionContainer(
                    HtmlUnescape().convert(widget._question.question))
              ] +
              optionWidgets,
        ),
      ),
    );
  }
}
