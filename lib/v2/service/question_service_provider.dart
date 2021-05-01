import 'package:flutter/material.dart';
import 'package:quiz/v2/mode/question.dart';
import 'package:quiz/v2/mode/question_parameter.dart';
import 'package:quiz/v2/repository/question_repository.dart';

class QuestionServiceProvider extends ChangeNotifier {
  QuestionRepository questionRepository = QuestionRepository();
  List<Question> questions;

  QuestionServiceProvider() {
    questions = null;
  }

  void fetchQuestion(QuizParameter quizParameter) async {
    questions = await questionRepository.getQuestions(quizParameter);
    notifyListeners();
  }
}
