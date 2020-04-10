import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/model/question.dart';
import 'package:quiz/pages/result_page.dart';
import 'package:quiz/widgets/overlay_widget.dart';

class QuizPage extends StatefulWidget {
  final String _url;

  const QuizPage({@required String url})
      : this._url = url,
        assert(url != null);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  List<Question> questions = [];
  Set<int> answered = Set<int>();
  int score = 0;
  Stream<List<Question>> stream;
  PageController controller = PageController();
  var unescape = new HtmlUnescape();
  int questionIndex = 0;
  bool overlayVisible = false;
  bool correct = true;

  Future<List<Question>> getQuestions() async {
    var res = await http.get(widget._url);
    var data = json.decode(res.body);

    if (data['response_code'] == 0) {
      for (var i in data['results']) {
        String category = unescape.convert(i['category']);
        String question = unescape.convert(i['question']);
        String correctAnswer = unescape.convert(i['correct_answer']);
        List<String> choices = [correctAnswer];

        for (var j in i['incorrect_answers']) {
          choices.add(unescape.convert(j));
        }

        choices.shuffle();

        questions.add(Question(
            category: category,
            question: question,
            correctAnswer: correctAnswer,
            choices: choices));
      }
    }

    questions.shuffle();
    return questions;
  }

  @override
  void initState() {
    super.initState();
    stream = getQuestions().asStream();
  }

  @override
  Widget build(BuildContext context) {
    Widget questionWidget({String question}) => Flexible(
          fit: FlexFit.loose,
          flex: 7,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    question,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
        );

    Widget choiceWidget({String choice, String correctAnswer}) => Flexible(
          fit: FlexFit.loose,
          flex: 2,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    choice,
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (choice == correctAnswer) {
                      ++score;
                      correct = true;
                    } else {
                      correct = false;
                    }
                    overlayVisible = true;
                  });
                },
              ),
            ),
          ),
        );

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String question = questions[questionIndex].question;
                String correctAnswer = questions[questionIndex].correctAnswer;
                List<String> choices = questions[questionIndex].choices;

                List<Widget> children = [
                  Flexible(
                    flex: 1,
                    child: LinearProgressIndicator(
                      value: questionIndex / questions.length,
                    ),
                  ),
                  questionWidget(question: question)
                ];

                for (String choice in choices) {
                  children.add(choiceWidget(
                      choice: choice, correctAnswer: correctAnswer));
                }

                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Flex(direction: Axis.vertical, children: children),
                    overlayVisible
                        ? OverlayWidget(
                            correct: correct,
                            correctAnswer: correctAnswer,
                            onTap: () {
                              setState(() {
                                overlayVisible = false;

                                if (questionIndex + 1 == questions.length) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                            score: score,
                                            fullMarks: questions.length),
                                      ));
                                } else {
                                  ++questionIndex;
                                }
                              });
                            },
                          )
                        : Container(),
                  ],
                );
              }

              return LinearProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
