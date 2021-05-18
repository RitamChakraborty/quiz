import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({Key key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  double rotation = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 75), (t) {
      setState(() {
        rotation++;
      });
    });
    // timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (rotation == 200.0) {
      timer.cancel();
    }

    return Container(
      height: 30,
      width: 30,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Transform.rotate(
        angle: pi * rotation / 100.0,
        // origin: Offset(15, 13),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 15,
              width: 4,
              color: Colors.white,
            ),
            Container(
              height: 15,
              width: 4,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
