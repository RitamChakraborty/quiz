import 'package:flutter/material.dart';

class FeelingLuckyButton extends StatefulWidget {
  final VoidCallback _floatingActionButtonOnPressed;

  const FeelingLuckyButton({@required VoidCallback onPressed})
      : this._floatingActionButtonOnPressed = onPressed,
        assert(onPressed != null);

  @override
  _FeelingLuckyButtonState createState() => _FeelingLuckyButtonState();
}

class _FeelingLuckyButtonState extends State<FeelingLuckyButton> {
  @override
  Widget build(BuildContext context) {
    final floatingActionButtonLabelText = Text(
      "I'm Feeling Lucky",
      style: TextStyle(
        color: Colors.blue,
      ),
    );

    return FloatingActionButton.extended(
      label: floatingActionButtonLabelText,
      onPressed: widget._floatingActionButtonOnPressed,
      backgroundColor: Colors.white.withOpacity(0.9),
    );
  }
}
