import 'dart:convert';

import 'package:flutter/material.dart';
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

  Future<List<Question>> getQuestions() async {
    var res = await http.get(widget._url);
    var data = json.decode(res.body);

    if (data['response_code'] == 0) {
      for (var i in data['results']) {
        String category = i['category'];
        String question = i['question'];
        String correctAnswer = i['correct_answer'];
        List<String> choices = [correctAnswer];

        for (var j in i['incorrect_answers']) {
          choices.add(j);
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
            builder: (context, snapshot) =>
            snapshot.hasData
                ? PageView.builder(
              controller: controller,
              itemCount: questions.length,
              itemBuilder: (context, questionIndex) {
                return ListTile(
                  enabled: !answered.contains(questionIndex),
                  title: Text(questions[questionIndex].question),
                  subtitle: ListView.builder(
                    itemCount: questions[questionIndex].choices.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        enabled: !answered.contains(questionIndex),
                        title:
                        Text(questions[questionIndex].choices[index]),
                        onTap: answered.contains(questionIndex)
                            ? null
                            : () {
                          setState(() {
                            answered.add(questionIndex);
                            if (questions[questionIndex]
                                .choices[index] ==
                                questions[questionIndex]
                                    .correctAnswer) {
                              ++score;
                            }
                            if (answered.length ==
                                questions.length) {
                              print("All answered, score: $score}");
                            } else {
                              controller
                                  .jumpToPage(questionIndex + 1);
                            }
                          });
                        },
                      );
                    },
                  ),
                );
              },
            )
                : LinearProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
