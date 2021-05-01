enum QuestionType {
  MULTIPLE,
  BOOLEAN,
  ANY,
}

extension QuestionTypeExtension on QuestionType {
  String get value {
    switch (this) {
      case QuestionType.MULTIPLE:
        return "multiple";
      case QuestionType.BOOLEAN:
        return "boolean";
      default:
        return "";
    }
  }
}
