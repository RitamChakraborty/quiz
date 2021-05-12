import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/model/question_difficulty.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/model/question_type.dart';
import 'package:quiz/model/quiz_category.dart';
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
  int _quizCategory = 0;
  int _questionCount = 10;
  int _difficultyIndex = 3;
  int _questionTypeIndex = 2;
  QuestionCategory _category = QuestionCategory.ANY;
  QuestionDifficulty _difficulty = QuestionDifficulty.ANY;
  QuestionType _type = QuestionType.ANY;

  QuizParameter get quizParameter => _quizParameter;

  int get quizCategory => _quizCategory;

  int get questionCount => _questionCount;

  int get difficultyIndex => _difficultyIndex;

  int get questionTypeIndex => _questionTypeIndex;

  QuestionCategory get category => _category;

  QuestionDifficulty get difficulty => _difficulty;

  QuestionType get type => _type;

  void selectCategory(int category,
      {QuestionCategory questionCategory = QuestionCategory.ANY}) {
    _quizCategory = category;
    _category = questionCategory;
    emit(QuizCategoryChosenState());
  }

  void changeQuestionCount(int value) {
    _questionCount = value;
    emit(ParameterUpdatedState());
  }

  void changeDifficulty(int index,
      {QuestionDifficulty questionDifficulty = QuestionDifficulty.ANY}) {
    _difficultyIndex = index;
    _difficulty = questionDifficulty;
    emit(ParameterUpdatedState());
  }

  void changeQuestionType(int index,
      {QuestionType questionType = QuestionType.ANY}) {
    _questionTypeIndex = index;
    _type = questionType;
    emit(ParameterUpdatedState());
  }

  void startQuiz() {
    _quizParameter = _quizService.getQuizParameter(
      categoryIndex: quizCategory,
      questionCount: questionCount,
      difficultyIndex: difficultyIndex,
      questionTypeIndex: questionTypeIndex,
    );

    emit(StartQuizState());
  }
}
