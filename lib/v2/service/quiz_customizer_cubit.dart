import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AbstractQuizCustomizerState {}

class InitialQuizCustomizerState extends AbstractQuizCustomizerState {}

class QuizCategoryChosenState extends AbstractQuizCustomizerState {}

class ParameterUpdatedState extends AbstractQuizCustomizerState {}

class StartQuizState extends AbstractQuizCustomizerState {}

class QuizCustomizerCubit extends Cubit<AbstractQuizCustomizerState> {
  QuizCustomizerCubit() : super(InitialQuizCustomizerState());

  int _quizCategory = 0;
  int _questionCount = 10;
  int _difficultyIndex = 0;
  int _questionTypeIndex = 0;

  int get quizCategory => _quizCategory;

  int get questionCount => _questionCount;

  int get difficultyIndex => _difficultyIndex;

  int get questionTypeIndex => _questionTypeIndex;

  void selectCategory(int category) {
    _quizCategory = category;
    emit(QuizCategoryChosenState());
  }

  void changeQuestionCount(int value) {
    _questionCount = value;
    emit(ParameterUpdatedState());
  }

  void changeDifficulty(int index) {
    _difficultyIndex = index;
    emit(ParameterUpdatedState());
  }

  void changeQuestionType(int index) {
    _questionTypeIndex = index;
    emit(ParameterUpdatedState());
  }

  void startQuiz() => emit(StartQuizState());
}
