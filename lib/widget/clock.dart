import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  final VoidCallback onTimerEnd;

  const Clock({@required this.onTimerEnd, Key key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  double rotation = 0;
  Timer timer;

  void resetTimer() {
    rotation = 0.0;

    if (timer != null && timer.isActive) {
      timer.cancel();
    }

    timer = Timer.periodic(Duration(milliseconds: 150), (t) {
      if (mounted) {
        setState(() {
          rotation++;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  @override
  void didUpdateWidget(covariant Clock oldWidget) {
    super.didUpdateWidget(oldWidget);
    resetTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (rotation >= 200.0) {
      timer.cancel();
      WidgetsFlutterBinding.ensureInitialized()
          .addPostFrameCallback((timeStamp) {
        resetTimer();
        widget.onTimerEnd();
      });
    }

    return Container(
      padding: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.purple,
        ),
        child: Transform.rotate(
          angle: pi * rotation / 100.0,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: 15,
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Container(
                height: 15,
                width: 4,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
