import 'package:flutter/material.dart';

class BouncingAnimation extends StatefulWidget {
  final Widget child;

  const BouncingAnimation({@required this.child, Key key}) : super(key: key);

  @override
  _BouncingAnimationState createState() => _BouncingAnimationState();
}

class _BouncingAnimationState extends State<BouncingAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = Tween<double>(begin: 0, end: 5).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ));

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
