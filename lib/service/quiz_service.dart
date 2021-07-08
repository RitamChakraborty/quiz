import 'package:meta/meta.dart';
import 'package:quiz/model/question_difficulty.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/model/quiz_category.dart';

class QuizService {
  /// Returns a list of category names in title case
  List<String> get categories => QuestionCategory.values.map((category) {
        // Take the string after the '.'
        String string = category.toString().toLowerCase().split(".")[1];

        // Convert the string to title case
        return string.substring(0, 1).toUpperCase() + string.substring(1);
      }).toList();

  QuizParameter getQuizParameter({
    @required int categoryIndex,
    @required int questionCount,
    @required QuestionDifficulty questionDifficulty,
    @required int questionTypeIndex,
  }) {
    int category;
    String difficulty;
    String type;

    if (categoryIndex != 0) {
      category = categoryIndex + 8;
    }

    switch (questionDifficulty) {
      case QuestionDifficulty.EASY:
      case QuestionDifficulty.MEDIUM:
      case QuestionDifficulty.HARD:
        {
          difficulty = questionDifficulty.value;
          break;
        }
      case QuestionDifficulty.ANY:
        break;
    }

    switch (questionTypeIndex) {
      case 0:
        {
          type = "multiple";
          break;
        }
      case 1:
        {
          type = "boolean";
          break;
        }
    }

    return QuizParameter(
      amount: questionCount,
      category: category,
      difficulty: difficulty,
      type: type,
    );
  }
}
