import 'package:flutter/material.dart';

class CustomizeQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Functions

    /// Decrease the question count
    void decreaseCount() {}

    /// Increase the question count
    void increaseCount() {}

    /// Change the difficulty of the questions
    void changeDifficulty() {}

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

    Widget difficultyButton(String difficulty) {
      return Expanded(
        child: MaterialButton(
          onPressed: changeDifficulty,
          child: Text(difficulty),
        ),
      );
    }

    Widget questionDifficultyPage() {
      return Container(
        child: Row(
          children: [
            difficultyButton("Easy"),
            difficultyButton("Medium"),
            difficultyButton("Hard"),
            difficultyButton("Mixed"),
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
          questionDifficultyPage(),
        ],
      ),
    );
  }
}
