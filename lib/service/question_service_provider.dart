import 'package:flutter/material.dart';
import 'package:quiz/model/question.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/repository/question_repository.dart';

class QuestionServiceProvider extends ChangeNotifier {
  QuestionRepository questionRepository = QuestionRepository();
  List<Question> _questions;
  int _index;
  int _score;
  bool _loading;
  bool _completed;

  QuestionServiceProvider() {
    _questions = null;
    _index = 0;
    _score = 0;
    _loading = true;
    _completed = false;
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
    print(value);
    if (value) {
      ++_score;
    }
  }

  void fetchQuestion(QuizParameter quizParameter) async {
    _questions = await questionRepository.getQuestions(quizParameter);
    _loading = false;

    // _questions.forEach((question) => print(question.toJson()));

    notifyListeners();
  }
}
