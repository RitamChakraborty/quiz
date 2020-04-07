import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/model/question.dart';

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
            builder: (context, snapshot) => snapshot.hasData
                ? PageView.builder(
                    controller: controller,
                    itemCount: questions.length,
                    itemBuilder: (context, questionIndex) {
                      String question = questions[questionIndex].question;
                      String correctAnswer =
                          questions[questionIndex].correctAnswer;
                      List<String> choices = questions[questionIndex].choices;
                      List<Widget> children = [];
                      children.add(Flexible(
                        fit: FlexFit.tight,
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.yellow,
                          child: Text(question),
                        ),
                      ));

                      for (String choice in choices) {
                        children.add(Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.red,
                              child: ListTile(
                                title: Center(child: Text(choice)),
                              ),
                            ),
                          ),
                        ));
                      }

                      return Flex(direction: Axis.vertical, children: children);

//                      return ListTile(
//                        enabled: !answered.contains(questionIndex),
//                        title: Text(),
//                        subtitle: ListView.builder(
//                          itemCount: ,
//                          shrinkWrap: true,
//                          itemBuilder: (context, index) {
//                            return ListTile(
//                              enabled: !answered.contains(questionIndex),
//                              title:
//                                  Text(choices[index]),
//                              onTap: answered.contains(questionIndex)
//                                  ? null
//                                  : () {
//                                      setState(() {
//                                        answered.add(questionIndex);
//                                        if (questions[questionIndex]
//                                                .choices[index] ==
//                                            ) {
//                                          ++score;
//                                        }
//                                        if (answered.length ==
//                                            questions.length) {
//                                          print("All answered, score: $score}");
//                                        } else {
//                                          controller
//                                              .jumpToPage(questionIndex + 1);
//                                        }
//                                      });
//                                    },
//                            );
//                          },
//                        ),
//                      );
                    },
                  )
                : LinearProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
