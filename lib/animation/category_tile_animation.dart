import 'package:flutter/material.dart';

class CategoryTileAnimation extends StatefulWidget {
  final Widget _child;

  const CategoryTileAnimation({@required Widget child, Key key})
      : this._child = child,
        assert(child != null),
        super(key: key);

  @override
  _CategoryTileAnimationState createState() => _CategoryTileAnimationState();
}

class _CategoryTileAnimationState extends State<CategoryTileAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = Tween<double>(begin: 48, end: 0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Container(
          margin: EdgeInsets.only(top: animation.value),
          child: child,
        );
      },
      child: widget._child,
    );
  }
}
