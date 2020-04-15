/// Model for the questions in the quiz
///
/// [category] is the [Question]'s [Category] as string
/// [question] is the question string
/// [choices] is the [List<String>] of choices
/// [correctAnswer] is the correct answer
class Question {
  final String category;
  final String question;
  final List<String> choices;
  final String correctAnswer;

  Question({this.category, this.question, this.choices, this.correctAnswer});

  @override
  String toString() {
    return question;
  }
}
