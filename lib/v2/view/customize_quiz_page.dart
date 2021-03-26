import 'package:flutter/material.dart';

class CustomizeQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Functions

    /// Decrease the question count
    void decreaseCount() {}

    /// Increase the question count
    void increaseCount() {}

    // Widgets
    Widget countWidget() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: decreaseCount,
              child: Icon(Icons.remove),
            ),
            Text("10"),
            FloatingActionButton(
              onPressed: increaseCount,
              child: Icon(Icons.add),
            )
          ],
        ),
      );
    }

    return Material(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          countWidget(),
        ],
      ),
    );
  }
}
