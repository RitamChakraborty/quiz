enum QuestionCategory {
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
  CARTOON,
  ANY
}

extension QuestionCategoryExtension on QuestionCategory {
  int get value {
    switch (this) {
      case QuestionCategory.KNOWLEDGE:
        return 9;
      case QuestionCategory.BOOKS:
        return 10;
      case QuestionCategory.FILM:
        return 11;
      case QuestionCategory.MUSIC:
        return 12;
      case QuestionCategory.THEATRES:
        return 13;
      case QuestionCategory.TELEVISION:
        return 14;
      case QuestionCategory.GAMES:
        return 15;
      case QuestionCategory.BGAMES:
        return 16;
      case QuestionCategory.SCIENCE:
        return 17;
      case QuestionCategory.COMPUTERS:
        return 18;
      case QuestionCategory.MATHEMATICS:
        return 19;
      case QuestionCategory.MYTHOLOGY:
        return 20;
      case QuestionCategory.SPORTS:
        return 21;
      case QuestionCategory.GEOGRAPHY:
        return 22;
      case QuestionCategory.HISTORY:
        return 23;
      case QuestionCategory.POLITICS:
        return 24;
      case QuestionCategory.ART:
        return 25;
      case QuestionCategory.CELEBRITIES:
        return 26;
      case QuestionCategory.ANIMALS:
        return 27;
      case QuestionCategory.VEHICLES:
        return 28;
      case QuestionCategory.COMICS:
        return 29;
      case QuestionCategory.GADGETS:
        return 30;
      case QuestionCategory.ANIME:
        return 31;
      case QuestionCategory.CARTOON:
        return 32;
      default:
        return 0;
    }
  }
}
