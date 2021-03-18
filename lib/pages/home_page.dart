import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/helper/constants.dart';
import 'package:quiz/helper/helper.dart';
import 'package:quiz/pages/quiz_page.dart';

/// Home page for the quiz to select game properties
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Start the game with number of questions to be 10
  int numberOfQuestions = 10;

  /// No [Category] is selected at first
  Category category = Category.ANY;

  /// No [Difficulty] is selected first
  Difficulty difficulty = Difficulty.ANY;

  /// No [Type] is selected first
  Type type = Type.ANY;

  /// [increaseButton] and [decreaseButton] is not pressed yet
  bool pointerDown = false;

  @override
  Widget build(BuildContext context) {
    /// Return a [Card] widget of a [ListTile]
    ///
    /// [title] is the title of the ListTile
    /// [subtitle] is the subtitle of the ListTile
    /// [menu] is a [PopupMenuButton]
    /// [child] if child is provided the child is used as subtitle
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

    /// A container to design drop down menu button icon
    final icon = Container(
      padding: EdgeInsets.all(8),
      child: Icon(
        Icons.arrow_drop_down,
        size: 40,
      ),
    );

    /// A container for plus button and minus button
    Widget buttonContainer({Widget child}) => Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).buttonColor,
          ),
          child: child,
        );

    /// Button to decrease the number of questions
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

    /// Button to increase the number of questions
    final plusButton = buttonContainer(
      /// Listen to [PointerDownEvent] or [PointerUpEvent]
      child: Listener(
        /// Wait for a 500 milliseconds
        /// Then decrease the number of questions
        /// Rapidly with 100 milliseconds wait
        /// After every decrease
        onPointerDown: (PointerDownEvent event) async {
          /// First change [pointerDown] event to true
          pointerDown = true;
          await Future.delayed(Duration(milliseconds: 500));

          /// Decrease rapidly
          while (pointerDown && numberOfQuestions < 50) {
            setState(() {
              ++numberOfQuestions;
            });

            await Future.delayed(Duration(milliseconds: 100));
          }
        },
        onPointerUp: (PointerUpEvent event) {
          /// When stop pressing the button
          /// Change [pointerDown] event to false
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

    /// A container to style [numberOfQuestions]
    final questionNumber = Container(
      child: Text(
        "$numberOfQuestions",
        style: Theme.of(context).textTheme.title,
      ),
    );

    /// [PopupMenuButton] for question [Category]
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

    /// [PopupMenuButton] for questions [Difficulty]
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

    /// [PopupMenuButton] for question [Type]
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

    /// Handle [startButton] onPressed event
    startButtonOnPressed() {
      /// Initial url get to get [numberOfQuestions] amount questions
      /// [URL] is defied as a constant in `constants.dart`
      String url = URL + "?amount=$numberOfQuestions";

      /// Add [Category] to the [url] if provided
      if (category != Category.ANY) {
        url += "&category=${getCategoryId(category)}";
      }

      /// Add [Difficulty] to the [url] if provided
      if (difficulty != Difficulty.ANY) {
        url +=
            "&difficulty=${difficulty.toString().split("\.")[1].toLowerCase()}";
      }

      /// Add [Type] to the [url] if provided
      if (type != Type.ANY) {
        url += "&type=${type.toString().split("\.")[1].toLowerCase()}";
      }

      print("API call : $url");

      /// At last go to [QuizPage]
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => QuizPage(url: url),
        ),
      );
    }

    /// [Button] to stat the quiz
    final Widget startButton = Container(
      padding: EdgeInsets.all(16),
      child: MaterialButton(
          color: Theme.of(context).buttonColor,
          child: Text("Start"),
          onPressed: startButtonOnPressed),
    );

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                /// [card] of [numberOfQuestions]
                /// Also to *increase* or *decrease* the questions
                card(
                  title: "Number of questions",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[minusButton, questionNumber, plusButton],
                  ),
                ),

                /// [card] to select question [Category]
                card(
                    title: "Select Category",
                    menu: categoryMenu,
                    subtitle: getCategory(category)),

                /// [card] to select questions [Difficulty]
                card(
                    title: "Select Difficulty",
                    menu: difficultyMenu,
                    subtitle: getDifficulty(difficulty)),

                /// [card] to select question [Type]
                card(
                    title: "Select Type",
                    menu: typeMenu,
                    subtitle: getType(type)),

                /// [startButton]
                startButton
              ],
            ),
          ),
        ),
      ),
    );
  }
}
