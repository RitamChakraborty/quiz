import 'package:flutter/material.dart';

class OverlayWidget extends StatefulWidget {
  final bool correct;
  final VoidCallback onTap;
  final String correctAnswer;

  OverlayWidget({this.correct, this.onTap, this.correctAnswer});

  @override
  _OverlayWidgetState createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.correct ? Duration(seconds: 2) : Duration(seconds: 1),
    );
    animation = Tween(begin: 50.0, end: 200.0).animate(CurvedAnimation(
      parent: animationController,
      curve: widget.correct ? Curves.elasticOut : Curves.easeOut,
    ));
    animationController.addListener(() => this.setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget animatedIcon = Container(
      padding: EdgeInsets.only(top: animation.value),
      child: Icon(
        widget.correct
            ? Icons.sentiment_very_satisfied
            : Icons.sentiment_very_dissatisfied,
        size: animation.value,
        color: Colors.white,
      ),
    );

    final Widget text = Container(
      child: Text(
        widget.correct ? "Correct Answer" : "Wrong Answer",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );

    final Widget correctAnswerText = Container(
      child: !widget.correct
          ? Text(
              "Right Answer is\n ${widget.correctAnswer}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            )
          : Container(),
    );

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        color: Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              animatedIcon,
              text,
              correctAnswerText,
            ]),
      ),
    );
  }
}
