import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/model/question_category.dart';
import 'package:quiz/model/question_difficulty.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/model/question_type.dart';
import 'package:quiz/service/quiz_service.dart';

abstract class AbstractQuizCustomizerState {}

class InitialQuizCustomizerState extends AbstractQuizCustomizerState {}

class QuizCategoryChosenState extends AbstractQuizCustomizerState {}

class ParameterUpdatedState extends AbstractQuizCustomizerState {}

class StartQuizState extends AbstractQuizCustomizerState {}

class QuizCustomizerCubit extends Cubit<AbstractQuizCustomizerState> {
  QuizCustomizerCubit() : super(InitialQuizCustomizerState());

  final QuizService _quizService = QuizService();
  QuizParameter _quizParameter;
  int _questionCount = 10;
  QuestionCategory _category = QuestionCategory.ANY;
  QuestionDifficulty _difficulty = QuestionDifficulty.ANY;
  QuestionType _type = QuestionType.ANY;

  QuizParameter get quizParameter => _quizParameter;

  int get questionCount => _questionCount;

  QuestionCategory get category => _category;

  QuestionDifficulty get difficulty => _difficulty;

  QuestionType get type => _type;

  void selectCategory(QuestionCategory questionCategory) {
    _category = questionCategory;
    emit(QuizCategoryChosenState());
  }

  void changeQuestionCount(int value) {
    _questionCount = value;
    emit(ParameterUpdatedState());
  }

  void changeDifficulty(QuestionDifficulty questionDifficulty) {
    _difficulty = questionDifficulty;
    emit(ParameterUpdatedState());
  }

  void changeQuestionType(QuestionType questionType) {
    _type = questionType;
    emit(ParameterUpdatedState());
  }

  void startQuiz() {
    _quizParameter = _quizService.getQuizParameter(
      questionCategory: _category,
      questionCount: questionCount,
      questionDifficulty: _difficulty,
      questionType: _type,
    );

    print('Quiz Parameter: ${_quizParameter.toJson()}');
    print('URL: ${_quizParameter.toString()}');

    emit(StartQuizState());
  }
}
