import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/model/question.dart';
import 'package:quiz/model/question_parameter.dart';

class QuestionRepository {
  final http.Client _client = http.Client();

  /// Parse Json response to a List<[Question]>
  ///
  /// @param body Response body of the api
  /// @return List of [Question]
  List<Question> _getQuestions(String body) {
    final List<Question> questions = [];
    final json = jsonDecode(body);

    if (json['response_code'] == 0) {
      final results = json['results'];

      for (int i = 0; i < results.length; ++i) {
        questions.add(Question.fromJson(results[i]));
      }
    }

    return questions;
  }

  /// Fetch questions from the api and parse it in an isolate
  ///
  /// @param quizParameter [QuizParameter] gives the api url
  /// @returns List of [Question] as Future
  Future<List<Question>> getQuestions(QuizParameter quizParameter) async {
    final http.Response response =
        await _client.get(Uri.parse(quizParameter.toString()));
    return compute(_getQuestions, response.body);
  }
}
