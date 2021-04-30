import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/v2/mode/question_parameter.dart';
import 'package:quiz/v2/service/quiz_service.dart';

void main() {
  final QuizService quizService = QuizService();

  test("getQuizParameter function test 1", () {
    // given
    int amount = 10;
    int categoryIndex = 0;
    int difficultyIndex = 0;
    int questionTypeIndex = 0;
    String expectedValue = "https://opentdb.com/api.php?amount=10";

    // When
    QuizParameter quizParameter = quizService.getQuizParameter(
      categoryIndex: categoryIndex,
      questionCount: amount,
      difficultyIndex: difficultyIndex,
      questionTypeIndex: questionTypeIndex,
    );
    String actualValue = quizParameter.toString();

    // Then
    expect(actualValue, expectedValue);
  });

  test("getQuizParameter function test 2", () {
    // given
    int amount = 10;
    int categoryIndex = 0;
    int difficultyIndex = 0;
    int questionTypeIndex = 0;
    String expectedValue = "https://opentdb.com/api.php?amount=10";

    // When
    QuizParameter quizParameter = quizService.getQuizParameter(
      categoryIndex: categoryIndex,
      questionCount: amount,
      difficultyIndex: difficultyIndex,
      questionTypeIndex: questionTypeIndex,
    );
    String actualValue = quizParameter.toString();

    // Then
    expect(actualValue, expectedValue);
  });

  test("getQuizParameter function test 3", () {
    // given
    int amount = 10;
    int categoryIndex = 1;
    int difficultyIndex = 2;
    int questionTypeIndex = 1;
    String expectedValue =
        "https://opentdb.com/api.php?amount=10&category=9&difficulty=medium&type=boolean";

    // When
    QuizParameter quizParameter = quizService.getQuizParameter(
      categoryIndex: categoryIndex,
      questionCount: amount,
      difficultyIndex: difficultyIndex,
      questionTypeIndex: questionTypeIndex,
    );
    String actualValue = quizParameter.toString();

    // Then
    expect(actualValue, expectedValue);
  });
}
