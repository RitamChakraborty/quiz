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
  Future<List<Question>> getQuestions() async {
    List<Question> questions = [];
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
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}
