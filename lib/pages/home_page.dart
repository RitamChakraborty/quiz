import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/helper/helper.dart';
import 'package:quiz/pages/quiz_page.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget card(
            {@required String title,
            String subtitle,
            Widget menu,
            Widget child}) =>
        Container(
          margin: EdgeInsets.all(16),
          child: Card(
            child: ListTile(
              title: Text(title),
              subtitle: child != null ? child : Text(subtitle),
              trailing: menu,
            ),
          ),
        );

    final icon = Container(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.arrow_drop_down,
        size: 40,
      ),
    );

    Widget buttonContainer({Widget child}) => Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).buttonColor,
          ),
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
      child: Text(
        "$numberOfQuestions",
        style: Theme.of(context).textTheme.title,
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

    startButtonOnPressed() {
      String url = "https://opentdb.com/api.php" + "?amount=$numberOfQuestions";

      if (category != Category.ANY) {
        url += "&category=${getCategoryId(category)}";
      }
      if (difficulty != Difficulty.ANY) {
        url +=
            "&difficulty=${difficulty.toString().split("\.")[1].toLowerCase()}";
      }
      if (type != Type.ANY) {
        url += "&type=${type.toString().split("\.")[1].toLowerCase()}";
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => QuizPage(url: url),
        ),
      );
    }

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
                    menu: categoryMenu,
                    subtitle: getCategory(category)),
                card(
                    title: "Select Difficulty",
                    menu: difficultyMenu,
                    subtitle: getDifficulty(difficulty)),
                card(
                    title: "Select Type",
                    menu: typeMenu,
                    subtitle: getType(type)),
                Container(
                  padding: EdgeInsets.all(16),
                  child: MaterialButton(
                      color: Theme.of(context).buttonColor,
                      child: Text("Start"),
                      onPressed: startButtonOnPressed),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
