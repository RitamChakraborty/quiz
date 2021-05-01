import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/v2/mode/question.dart';
import 'package:quiz/v2/mode/question_parameter.dart';
import 'package:quiz/v2/repository/question_repository.dart';

void main() {
  final QuestionRepository questionRepository = QuestionRepository();

  test("getQuestions test 1", () async {
    final quizParameter = QuizParameter(
        amount: 10, category: 9, difficulty: "medium", type: "boolean");
    List<Question> questions =
        await questionRepository.getQuestions(quizParameter);

    questions.forEach((question) => print(question.toJson()));
  });
}
