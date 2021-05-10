import 'package:flutter/material.dart';
import 'package:quiz/model/question.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/repository/question_repository.dart';

class QuestionServiceProvider extends ChangeNotifier {
  QuestionRepository questionRepository = QuestionRepository();
  List<Question> _questions;
  int _index = 0;

  QuestionServiceProvider() {
    _questions = null;
  }

  List<Question> get questions => _questions;

  int get index => _index;

  void nextQuestion() {
    ++_index;
    notifyListeners();
  }

  void fetchQuestion(QuizParameter quizParameter) async {
    _questions = await questionRepository.getQuestions(quizParameter);
    notifyListeners();
  }
}
