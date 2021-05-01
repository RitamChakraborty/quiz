import 'package:meta/meta.dart';
import 'package:quiz/model/question_parameter.dart';

/// All the categories of [Question]
enum Category {
  KNOWLEDGE,
  BOOKS,
  FILM,
  MUSIC,
  THEATRES,
  TELEVISION,
  GAMES,
  BGAMES,
  SCIENCE,
  COMPUTERS,
  MATHEMATICS,
  MYTHOLOGY,
  SPORTS,
  GEOGRAPHY,
  HISTORY,
  POLITICS,
  ART,
  CELEBRITIES,
  ANIMALS,
  VEHICLES,
  COMICS,
  GADGETS,
  ANIME,
  CARTOON
}

class QuizService {
  /// Returns a list of category names in title case
  List<String> get categories => Category.values.map((category) {
        // Take the string after the '.'
        String string = category.toString().toLowerCase().split(".")[1];

        // Convert the string to title case
        return string.substring(0, 1).toUpperCase() + string.substring(1);
      }).toList();

  QuizParameter getQuizParameter({
    @required int categoryIndex,
    @required int questionCount,
    @required int difficultyIndex,
    @required int questionTypeIndex,
  }) {
    int category;
    String difficulty;
    String type;

    if (categoryIndex != 0) {
      category = categoryIndex + 8;
    }

    switch (difficultyIndex) {
      case 1:
        {
          difficulty = "easy";
          break;
        }
      case 2:
        {
          difficulty = "medium";
          break;
        }
      case 3:
        {
          difficulty = "hard";
          break;
        }
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
