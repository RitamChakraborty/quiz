import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/model/question.dart';
import 'package:quiz/pages/result_page.dart';

class QuizPage extends StatefulWidget {
  final String _url;

  const QuizPage({@required String url})
      : this._url = url,
        assert(url != null);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
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

        questions.add(Question(
            category: category,
            question: question,
            correctAnswer: correctAnswer,
            choices: choices));
      }
    }

    return questions;
  }

  @override
  void initState() {
    super.initState();
    stream = getQuestions().asStream();
  }

  @override
  Widget build(BuildContext context) {
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
                List<Widget> children = [];
                children.add(Flexible(
                  fit: FlexFit.tight,
                  flex: 5,
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
                      elevation: 5,
                    ),
                  ),
                ));

                for (String choice in choices) {
                  children.add(Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Center(child: Text(choice)),
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
                  ));
                }

                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Flex(direction: Axis.vertical, children: children),
                    overlayVisible
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                overlayVisible = false;
                                if (questionIndex + 1 == questions.length) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                            score: score,
                                            marks: questions.length),
                                      ));
                                } else {
                                  ++questionIndex;
                                }
                              });
                            },
                            child: Container(
                              color: Colors.black87,
                              alignment: Alignment.center,
                              child: Icon(
                                correct
                                    ? Icons.sentiment_very_satisfied
                                    : Icons.sentiment_very_dissatisfied,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
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
