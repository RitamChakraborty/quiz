enum QuestionDifficulty { EASY, MEDIUM, HARD, ANY }

extension QuestionDifficultyExtension on QuestionDifficulty {
  String get value {
    switch (this) {
      case QuestionDifficulty.EASY:
        return "easy";
      case QuestionDifficulty.MEDIUM:
        return "medium";
      case QuestionDifficulty.HARD:
        return "hard";
      default:
        return "";
    }
  }
}
