import 'package:flutter/material.dart';
import 'package:quiz/v2/mode/question.dart';
import 'package:quiz/v2/mode/question_parameter.dart';
import 'package:quiz/v2/repository/question_repository.dart';

class QuestionServiceProvider extends ChangeNotifier {
  QuestionRepository questionRepository = QuestionRepository();
  List<Question> _questions;

  QuestionServiceProvider() {
    _questions = null;
  }

  List<Question> get questions => _questions;

  void fetchQuestion(QuizParameter quizParameter) async {
    _questions = await questionRepository.getQuestions(quizParameter);
    notifyListeners();
  }
}
