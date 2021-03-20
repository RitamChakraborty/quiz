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
}
