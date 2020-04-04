import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfQuestions = 10;
  String category = "Any Category";
  String difficulty = "Any Difficulty";
  String type = "Any Type";

  @override
  Widget build(BuildContext context) {
    Widget card({@required String title, @required Widget child}) => Container(
          margin: EdgeInsets.all(8),
          child: Card(
            child: ListTile(
              title: Text(title),
              subtitle: child,
            ),
          ),
        );

    final minusButton = Container(
      child: FloatingActionButton(
        child: Icon(Icons.remove),
        onPressed: () {
          if (numberOfQuestions > 1) {
            setState(() {
              --numberOfQuestions;
            });
          }
        },
      ),
    );

    final plusButton = Container(
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (numberOfQuestions < 50) {
            setState(() {
              ++numberOfQuestions;
            });
          }
        },
      ),
    );

    final questionNumber = Container(
      child: Text("$numberOfQuestions"),
    );

    Widget selector({@required String title}) => Container(
          child: ListTile(
            title: Text(title),
            trailing: Icon(
              Icons.arrow_drop_down,
            ),
          ),
        );

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                card(
                  title: "Number of questions",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[minusButton, questionNumber, plusButton],
                  ),
                ),
                card(
                    title: "Select Category", child: selector(title: category)),
                card(
                    title: "Select Difficulty",
                    child: selector(title: difficulty)),
                card(title: "Select Type", child: selector(title: type)),
                Container(
                  padding: EdgeInsets.all(16),
                  child: MaterialButton(
                    child: Text("Start"),
                    onPressed: () {
                      print("Wala!");
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
