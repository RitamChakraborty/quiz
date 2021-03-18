import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz/pages/home_page.dart';

class ResultPage extends StatefulWidget {
  final int score;
  final int fullMarks;

  const ResultPage({this.score, this.fullMarks});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: 1,
        ));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

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

    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Want to play again?",
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      actions: <Widget>[
        flatButton(
          "Yes",
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        flatButton("No", () {
          if (!kIsWeb) {
            exit(0);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        }),
      ],
    );

    final Widget scoreWidget = Container(
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
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog;
            });
      },
      child: Material(
          child: InkWell(
        splashColor: Colors.white,
        onTap: () {
          showDialog(
              context: context,
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
