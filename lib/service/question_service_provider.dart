import 'package:flutter/material.dart';
import 'package:quiz/model/question.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/repository/question_repository.dart';

class QuestionServiceProvider extends ChangeNotifier {
  QuestionRepository questionRepository = QuestionRepository();
  List<Question> _questions;
  int _index = 0;
  int _score = 0;
  bool _loading = true;
  bool _completed = false;

  QuestionServiceProvider() {
    _questions = null;
  }

  Question get question {
    if (_questions == null || _index == _questions.length) {
      return null;
    }

    return _questions[index];
  }

  int get index => _index;

  int get count => _questions.length;

  int get score => _score;

  bool get loading => _loading;

  bool get completed => _completed;

  void nextQuestion() {
    ++_index;

    if (index == _questions.length) {
      _completed = true;
    }

    notifyListeners();
  }

  void answer(bool value) {
    if (value) {
      ++_score;
    }
  }

  void fetchQuestion(QuizParameter quizParameter) async {
    _questions = await questionRepository.getQuestions(quizParameter);
    _loading = false;
    notifyListeners();
  }
}
