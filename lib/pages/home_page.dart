import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/pages/quiz_page.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfQuestions = 10;
  Category category = Category.ANY;
  Difficulty difficulty = Difficulty.ANY;
  Type type = Type.ANY;
  bool pointerDown = false;

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

  @override
  Widget build(BuildContext context) {
    Widget card({@required String title, @required Widget child}) => Container(
          margin: EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(title),
                subtitle: child,
              ),
            ),
          ),
        );

    Widget buttonContainer({Widget child}) => Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).buttonColor),
          child: child,
        );

    final minusButton = buttonContainer(
      child: Listener(
        onPointerDown: (PointerDownEvent event) async {
          pointerDown = true;
          await Future.delayed(Duration(milliseconds: 500));

          while (pointerDown && numberOfQuestions > 1) {
            setState(() {
              --numberOfQuestions;
            });
            print(numberOfQuestions.toString());
            await Future.delayed(Duration(milliseconds: 100));
          }
        },
        onPointerUp: (PointerUpEvent event) {
          pointerDown = false;
        },
        child: IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            if (numberOfQuestions > 1) {
              setState(() {
                --numberOfQuestions;
              });
            }
          },
        ),
      ),
    );

    final plusButton = buttonContainer(
      child: Listener(
        onPointerDown: (PointerDownEvent event) async {
          pointerDown = true;
          await Future.delayed(Duration(milliseconds: 500));

          while (pointerDown && numberOfQuestions < 50) {
            setState(() {
              ++numberOfQuestions;
            });
            await Future.delayed(Duration(milliseconds: 100));
          }
        },
        onPointerUp: (PointerUpEvent event) {
          pointerDown = false;
        },
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            if (numberOfQuestions < 50) {
              setState(() {
                ++numberOfQuestions;
              });
            }
          },
        ),
      ),
    );

    final questionNumber = Container(
      child: Text("$numberOfQuestions"),
    );

    final icon = Container(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.arrow_drop_down,
        size: 40,
      ),
    );

    final categoryMenu = PopupMenuButton<Category>(
      child: icon,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Category>>[
        const PopupMenuItem(
          value: Category.ANY,
          child: Text("Any Category"),
        ),
        const PopupMenuItem(
          value: Category.KNOWLEDGE,
          child: Text("General Knowledge"),
        ),
        const PopupMenuItem(
          value: Category.BOOKS,
          child: Text("Books"),
        ),
        const PopupMenuItem(
          value: Category.FILM,
          child: Text("Films"),
        ),
        const PopupMenuItem(
          value: Category.MUSIC,
          child: Text("Music"),
        ),
        const PopupMenuItem(
          value: Category.THEATRES,
          child: Text("Theatres"),
        ),
        const PopupMenuItem(
          value: Category.TELEVISION,
          child: Text("Television"),
        ),
        const PopupMenuItem(
          value: Category.GAMES,
          child: Text("Games"),
        ),
        const PopupMenuItem(
          value: Category.BGAMES,
          child: Text("Board Games"),
        ),
        const PopupMenuItem(
          value: Category.SCIENCE,
          child: Text("Science"),
        ),
        const PopupMenuItem(
          value: Category.COMPUTERS,
          child: Text("Computers"),
        ),
        const PopupMenuItem(
          value: Category.MATHEMATICS,
          child: Text("Mathematics"),
        ),
        const PopupMenuItem(
          value: Category.MYTHOLOGY,
          child: Text("Mythology"),
        ),
        const PopupMenuItem(
          value: Category.SPORTS,
          child: Text("Sport"),
        ),
        const PopupMenuItem(
          value: Category.GEOGRAPHY,
          child: Text("Geography"),
        ),
        const PopupMenuItem(
          value: Category.HISTORY,
          child: Text("History"),
        ),
        const PopupMenuItem(
          value: Category.POLITICS,
          child: Text("Politics"),
        ),
        const PopupMenuItem(
          value: Category.ART,
          child: Text("Art"),
        ),
        const PopupMenuItem(
          value: Category.CELEBRITIES,
          child: Text("Celebrities"),
        ),
        const PopupMenuItem(
          value: Category.ANIMALS,
          child: Text("Animals"),
        ),
        const PopupMenuItem(
          value: Category.VEHICLES,
          child: Text("Vehicles"),
        ),
        const PopupMenuItem(
          value: Category.COMICS,
          child: Text("Comics"),
        ),
        const PopupMenuItem(
          value: Category.GADGETS,
          child: Text("Gadgets"),
        ),
        const PopupMenuItem(
          value: Category.ANIME,
          child: Text("Anime"),
        ),
        const PopupMenuItem(
          value: Category.CARTOON,
          child: Text("Cartoon"),
        ),
      ],
      onSelected: (Category categoryType) {
        setState(() {
          category = categoryType;
        });
      },
    );

    final difficultyMenu = PopupMenuButton<Difficulty>(
      child: icon,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Difficulty>>[
        const PopupMenuItem(
          value: Difficulty.ANY,
          child: Text("Any Difficulty"),
        ),
        const PopupMenuItem(
          value: Difficulty.EASY,
          child: Text("Easy"),
        ),
        const PopupMenuItem(
          value: Difficulty.MEDIUM,
          child: Text("Medium"),
        ),
        const PopupMenuItem(
          value: Difficulty.HARD,
          child: Text("Hard"),
        ),
      ],
      onSelected: (difficultyType) {
        setState(() {
          difficulty = difficultyType;
        });
      },
    );

    final typeMenu = PopupMenuButton<Type>(
      child: icon,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Type>>[
        const PopupMenuItem(
          value: Type.ANY,
          child: Text("Any type"),
        ),
        const PopupMenuItem(
          value: Type.MULTIPLE,
          child: Text("Multiple Choice"),
        ),
        const PopupMenuItem(
          value: Type.BOOLEAN,
          child: Text("True and False"),
        ),
      ],
      onSelected: (typeType) {
        setState(() {
          type = typeType;
        });
      },
    );

    Widget selector({@required String title, @required Widget child}) =>
        Container(
          child: ListTile(
            title: Text(title),
            trailing: child,
          ),
        );

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                card(
                  title: "Number of questions",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[minusButton, questionNumber, plusButton],
                  ),
                ),
                card(
                    title: "Select Category",
                    child: selector(
                        title: getCategory(category), child: categoryMenu)),
                card(
                    title: "Select Difficulty",
                    child: selector(
                        title: getDifficulty(difficulty),
                        child: difficultyMenu)),
                card(
                    title: "Select Type",
                    child: selector(title: getType(type), child: typeMenu)),
                Container(
                  padding: EdgeInsets.all(16),
                  child: MaterialButton(
                    color: Theme.of(context).buttonColor,
                    child: Text("Start"),
                    onPressed: () {
                      String url = "https://opentdb.com/api.php" +
                          "?amount=$numberOfQuestions";

                      if (category != Category.ANY) {
                        url += "&category=${getCategoryId(category)}";
                      }
                      if (difficulty != Difficulty.ANY) {
                        url +=
                            "&difficulty=${difficulty.toString().split("\.")[1].toLowerCase()}";
                      }
                      if (type != Type.ANY) {
                        url +=
                            "&type=${type.toString().split("\.")[1].toLowerCase()}";
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => QuizPage(url: url),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
