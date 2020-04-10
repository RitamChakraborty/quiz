import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'home_page.dart';

class ResultPage extends StatefulWidget {
  final int score;
  final int fullMarks;

  const ResultPage({this.score, this.fullMarks});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 1000,
        ));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
  }

  @override
  dispose() {
    super.dispose();
    animationController.dispose();
  }

  Widget flatButton(String text, VoidCallback onTap) => FlatButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        onPressed: onTap,
      );

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

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
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        flatButton("No", () => exit(0)),
      ],
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
            Container(
              height: mediaQuery.height * .25 * animation.value,
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20.0, // has the effect of softening the shadow
                    spreadRadius: 5.0, // has the effect of extending the shadow
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
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              "Score",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(5.0, 5.0),
                    blurRadius: 5.0,
                    color: Colors.black12,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
