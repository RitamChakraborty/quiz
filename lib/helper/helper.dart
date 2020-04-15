enum Category {
  ANY,
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

enum Difficulty { ANY, EASY, MEDIUM, HARD }

enum Type { ANY, MULTIPLE, BOOLEAN }

String getCategory(Category categoryType) {
  switch (categoryType) {
    case Category.ANY:
      return "Any Category";
    case Category.KNOWLEDGE:
      return "General Knowledge";
    case Category.BOOKS:
      return "Books";
    case Category.FILM:
      return "Films";
    case Category.MUSIC:
      return "Music";
    case Category.THEATRES:
      return "Theatres";
    case Category.TELEVISION:
      return "Television";
    case Category.GAMES:
      return "Video Games";
    case Category.BGAMES:
      return "Board Games";
    case Category.SCIENCE:
      return "Science and Nature";
    case Category.COMPUTERS:
      return "Computers";
    case Category.MATHEMATICS:
      return "Mathematics";
    case Category.MYTHOLOGY:
      return "Mythology";
    case Category.SPORTS:
      return "Sports";
    case Category.GEOGRAPHY:
      return "Geography";
    case Category.HISTORY:
      return "History";
    case Category.POLITICS:
      return "Politices";
    case Category.ART:
      return "Art";
    case Category.CELEBRITIES:
      return "Celebrities";
    case Category.ANIMALS:
      return "Animals";
    case Category.VEHICLES:
      return "Vehicles";
    case Category.COMICS:
      return "Comics";
    case Category.GADGETS:
      return "Gadgets";
    case Category.ANIME:
      return "Anime and Manga";
    case Category.CARTOON:
      return "Cartoon and Animation";
    default:
      return "Unknown";
  }
}

int getCategoryId(Category categoryType) {
  int id = 8;
  for (Category c in Category.values) {
    if (c == categoryType) {
      break;
    } else {
      ++id;
    }
  }

  return id;
}

String getDifficulty(Difficulty difficultyType) {
  switch (difficultyType) {
    case Difficulty.ANY:
      return "Any Difficulty";
    case Difficulty.EASY:
      return "Easy";
    case Difficulty.MEDIUM:
      return "Medium";
    case Difficulty.HARD:
      return "Hard";
    default:
      return "Unknown";
  }
}

String getType(Type typeType) {
  switch (typeType) {
    case Type.ANY:
      return "Any type";
    case Type.MULTIPLE:
      return "Multiple Choice";
    case Type.BOOLEAN:
      return "True and False";
    default:
      return "Unknown";
  }
}
