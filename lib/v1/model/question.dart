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
