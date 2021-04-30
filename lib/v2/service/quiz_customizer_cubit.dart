import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AbstractQuizCustomizerState {}

class InitialQuizCustomizerState extends AbstractQuizCustomizerState {}

class QuizCategoryEventChooseState extends AbstractQuizCustomizerState {}

class QuizCustomizerCubit extends Cubit<AbstractQuizCustomizerState> {
  QuizCustomizerCubit() : super(InitialQuizCustomizerState());

  String _quizCategory = "any";

  String get quizCategory => _quizCategory;

  void selectCategory(String category) {
    _quizCategory = category;
    emit(QuizCategoryEventChooseState());
  }
}
