import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz/v2/mode/question.dart';
import 'package:quiz/v2/mode/question_parameter.dart';

class QuestionRepository {
  final http.Client _client = http.Client();

  Future<List<Question>> getQuestions(QuizParameter quizParameter) async {
    final List<Question> questions = [];
    final http.Response response =
        await _client.get(Uri.parse(quizParameter.toString()));
    final String body = response.body;
    final List<dynamic> json = jsonDecode(body);

    for (int i = 0; i < json.length; ++i) {
      questions.add(Question.fromJson(json[i]));
    }

    return questions;
  }
}
