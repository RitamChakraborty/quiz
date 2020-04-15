import 'package:flutter/material.dart';

/// Returns the [overlayWidget] for [QuizPage]
///
/// [correct] is `true` if correct answer is selected
/// [onTap] handler of the `onTap` property
/// [correctAnswer] correct answer is shown
/// If correct answer is not selected
class OverlayWidget extends StatefulWidget {
  final bool correct;
  final VoidCallback onTap;
  final String correctAnswer;

  OverlayWidget({this.correct, this.onTap, this.correctAnswer});

  @override
  _OverlayWidgetState createState() => _OverlayWidgetState();
}

/// OverlayWidget uses animation
/// [animationController] controls the [Animation]
/// [animation] gives the value for the widget
class _OverlayWidgetState extends State<OverlayWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();

    /// [animationController] is initialized
    /// With different animation speed
    /// Depending on if the answer is rite or wrong
    /// If `right answer` then [Duration] is `2` seconds
    /// Else [Duration] is `1` second
    animationController = AnimationController(
      vsync: this,
      duration: widget.correct ? Duration(seconds: 2) : Duration(seconds: 1),
    );

    /// [animation] is initialized
    /// With a [Tween] animation that begins from `50` and ends at `200`
    /// If `right answer` then curve is `elasticOut`
    /// Otherwise curve is `easeOut`
    /// [Tween] is started from 50
    /// To avoid `negative value` during `elasticOut` animation
    animation = Tween(begin: 50.0, end: 200.0).animate(CurvedAnimation(
      parent: animationController,
      curve: widget.correct ? Curves.elasticOut : Curves.easeOut,
    ));

    /// Listen to the [animation]
    /// And rebuild widget tree
    /// When `animation.value` is changed
    animationController.addListener(() => this.setState(() {}));

    /// Start the [animation]
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    /// Shows the animatedIcon
    final Widget animatedIcon = Container(
      padding: EdgeInsets.only(top: animation.value),
      child: Icon(
        /// If the answer is right
        /// Then shows `Very Satisfied` icon
        /// Otherwise shows `Very Dissatisfied` icon
        widget.correct
            ? Icons.sentiment_very_satisfied
            : Icons.sentiment_very_dissatisfied,
        size: animation.value,
        color: Colors.white,
      ),
    );

    /// Shows `Correct Answer` if the answer is right
    /// Otherwise shows `Wrong Answer`
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

    /// Shows the [correctAnswer] as text
    /// If the answer is `wrong` then shows the [correctAnswer`
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
