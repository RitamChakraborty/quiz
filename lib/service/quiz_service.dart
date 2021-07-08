import 'package:meta/meta.dart';
import 'package:quiz/model/question_category.dart';
import 'package:quiz/model/question_difficulty.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/model/question_type.dart';

class QuizService {
  /// Returns a list of category names in title case
  List<String> get categories => QuestionCategory.values.map((category) {
        // Take the string after the '.'
        String string = category.toString().toLowerCase().split(".")[1];

        // Convert the string to title case
        return string.substring(0, 1).toUpperCase() + string.substring(1);
      }).toList();

  QuizParameter getQuizParameter({
    @required QuestionCategory questionCategory,
    @required int questionCount,
    @required QuestionDifficulty questionDifficulty,
    @required QuestionType questionType,
  }) {
    int category =
        questionCategory == QuestionCategory.ANY ? 0 : questionCategory.value;
    String difficulty = questionDifficulty.value;
    String type = questionType.value;

    return QuizParameter(
      amount: questionCount,
      category: category,
      difficulty: difficulty,
      type: type,
    );
  }
}
