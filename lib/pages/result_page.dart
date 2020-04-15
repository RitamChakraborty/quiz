import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz/pages/home_page.dart';

/// Show the score of the game
///
/// [score] is the score earned from the game
/// [fullMarks] is the full marks of the game
class ResultPage extends StatefulWidget {
  final int score;
  final int fullMarks;

  const ResultPage({this.score, this.fullMarks});

  @override
  _ResultPageState createState() => _ResultPageState();
}

/// [ResultPage] uses animation
///
/// [animationController] is an [AnimationController] to control the animation
/// [animation] is an [Animation] controlled by the [animationController]
class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    /// Initialize the [AnimationController]
    /// The animation will stay for `1` second
    animationController = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: 1,
        ));

    /// Initialize the [Animation]
    /// As a [CurvedAnimation]
    /// With a curve of `easeInOut`
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    /// Listen to the animation
    /// And rebuild the widget tree
    /// If the value is changed
    animation.addListener(() => setState(() {}));

    /// Start the [animation]
    animationController.forward();
  }

  @override
  dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    /// Returns a [FlatButton] for `Yes` and `No`
    /// On the [alertDialog]
    Widget flatButton(String text, VoidCallback onTap) => FlatButton(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          onPressed: onTap,
        );

    /// A [AlertDialog] prompt
    /// To ask the player if he/she
    /// Wants to play again or not
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Want to play again?",
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      actions: <Widget>[
        /// If `Yes` button is pressed
        /// Then Navigate to [HomePage]
        flatButton(
          "Yes",
          () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),

        /// If `No` button is pressed
        /// Then `close` the app
        flatButton("No", () => exit(0)),
      ],
    );

    /// Show the score with animation
    final Widget scoreWidget = Container(
      /// Change the height of the container
      /// By listening the [animation] `value`
      height: mediaQuery.height * .25 * animation.value,
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0,
            // has the effect of softening the shadow
            spreadRadius: 5.0,
            // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Center(
        /// Rotate the text
        /// By listening to [animation] `value`
        child: Transform.rotate(
          angle: animation.value * pi * 4,
          child: Text(
            "${widget.score}/${widget.fullMarks}",
            style: TextStyle(
              color: Colors.black87,
              fontSize: animation.value * 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    /// Show the `Score Text` with a shadow
    final Widget scoreText = Text(
      "Score",
      style: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(5.0, 5.0),
            blurRadius: 5.0,
            color: Theme.of(context).backgroundColor,
          ),
        ],
      ),
    );

    return WillPopScope(
      /// Handle the event for back button pressed
      onWillPop: () {
        return showDialog(
            context: context,

            /// If back button is pressed
            /// Then show the [alertDialog]
            builder: (BuildContext context) {
              return alertDialog;
            });
      },
      child: Material(
          child: InkWell(
        splashColor: Colors.white,

        /// Handle the onTap event for the [ResultPage]
        onTap: () {
          showDialog(
              context: context,

              /// When tapped show the [alertDialog]
              builder: (BuildContext context) {
                return alertDialog;
              });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            scoreWidget,
            SizedBox(
              height: 24.0,
            ),
            scoreText,
          ],
        ),
      )),
    );
  }
}
