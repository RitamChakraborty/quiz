import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz/model/question.dart';
import 'package:quiz/model/question_parameter.dart';

class QuestionRepository {
  final http.Client _client = http.Client();

  Future<List<Question>> getQuestions(QuizParameter quizParameter) async {
    final List<Question> questions = [];
    final http.Response response =
        await _client.get(Uri.parse(quizParameter.toString()));
    final String body = response.body;
    final json = jsonDecode(body);

    if (json['response_code'] == 0) {
      final results = json['results'];

      for (int i = 0; i < results.length; ++i) {
        questions.add(Question.fromJson(results[i]));
      }
    }

    return questions;
  }
}
