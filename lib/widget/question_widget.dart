import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz/model/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question _question;
  final ValueChanged<bool> _answer;

  const QuestionWidget(
      {@required Question question,
      @required ValueChanged<bool> answer,
      Key key})
      : this._question = question,
        this._answer = answer,
        assert(question != null),
        assert(answer != null),
        super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  List<String> options;
  List<Widget> optionWidgets;
  List<Color> colors;
  List<Widget> resultIcons;
  final color = Colors.deepPurple;
  final correctColor = Colors.green;
  final wrongColor = Colors.red;
  Widget correctIcon;
  Widget wrongIcon;
  var correctAnswerIndex;
  var answered;

  @override
  void initState() {
    super.initState();

    options = widget._question.options;
    optionWidgets = [];
    colors = [];
    resultIcons = [];
    correctAnswerIndex = 0;
    answered = false;

    for (int i = 0; i < options.length; ++i) {
      colors.add(color);
      resultIcons.add(Container());

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
    resultIcons = [];
    correctAnswerIndex = 0;
    answered = false;

    for (int i = 0; i < options.length; ++i) {
      colors.add(color);
      resultIcons.add(Container());

      if (options[i] == widget._question.correctAnswer) {
        correctAnswerIndex = i;
      }
    }
  }

  Widget questionContainer(String question) => Expanded(
        child: Container(
          padding: const EdgeInsets.only(bottom: 24),
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Text(
                  question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget optionWidget(int index, String option, {bool isCorrect = false}) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: EdgeInsets.only(bottom: index == options.length - 1 ? 0 : 16),
        child: Material(
          elevation: 10,
          color: color,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: colors[index],
              width: 2,
            ),
          ),
          child: MaterialButton(
            onPressed: answered
                ? null
                : () {
                    setState(() {
                      colors[index] = wrongColor;
                      colors[correctAnswerIndex] = correctColor;

                      resultIcons[index] = Icon(
                        Icons.cancel_outlined,
                        color: colors[index],
                      );
                      resultIcons[correctAnswerIndex] = Icon(
                        Icons.check_circle_outline_rounded,
                        color: colors[index],
                      );

                      answered = true;
                    });

                    widget._answer(answered && index == correctAnswerIndex);
                  },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              alignment: Alignment.centerLeft,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 10,
                    fit: FlexFit.loose,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        option,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: resultIcons[index],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    optionWidgets = List.generate(options.length, (i) {
      String option = HtmlUnescape().convert(options[i]);
      return option == widget._question.correctAnswer
          ? optionWidget(i, option, isCorrect: true)
          : optionWidget(i, option);
    });

    return Container(
      child: Column(
        children: [
              questionContainer(
                  HtmlUnescape().convert(widget._question.question))
            ] +
            optionWidgets,
      ),
    );
  }
}
