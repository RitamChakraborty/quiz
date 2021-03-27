import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomizeQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Functions

    /// Change question count
    void changeQuestionCount(double value) {}

    /// Change the difficulty of the questions
    void changeDifficulty() {}

    /// Change question type
    void changeQuestionType(dynamic value) {}

    /// Start the quiz by navigating to the quiz page
    void startQuiz() {}

    // Widgets
    Widget countWidget() {
      return Container(
        child: Slider(
          value: 10.0,
          onChanged: changeQuestionCount,
          min: 1,
          max: 50,
          divisions: 1,
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

    Widget questionDifficultyWidget() {
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

    Widget questionTypeWidget() {
      return CupertinoSlidingSegmentedControl(
        children: {
          0: Text("MCQ"),
          1: Text("True-False"),
          2: Text("Either"),
        },
        onValueChanged: changeQuestionType,
      );
    }

    return Material(
      color: Colors.grey.shade100,
      child: Scaffold(
        floatingActionButton: MaterialButton(
          onPressed: startQuiz,
          color: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text("Let's GO!"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            countWidget(),
            questionDifficultyWidget(),
            questionTypeWidget(),
          ],
        ),
      ),
    );
  }
}
