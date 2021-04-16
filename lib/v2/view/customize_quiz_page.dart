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
    Widget countCounter() {
      return Expanded(
        child: Container(
          color: Colors.red,
          child: Slider(
            value: 10.0,
            onChanged: changeQuestionCount,
            min: 1,
            max: 50,
            divisions: 1,
          ),
        ),
      );
    }

    Widget difficultyButton(String difficulty) {
      return Expanded(
        child: GestureDetector(
          onTap: changeDifficulty,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(difficulty),
          ),
        ),
      );
    }

    Widget questionDifficultyContainer() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              difficultyButton("Easy"),
              difficultyButton("Medium"),
              difficultyButton("Hard"),
              difficultyButton("Mixed"),
            ],
          ),
        ),
      );
    }

    Widget questionTypeContainer() {
      return Expanded(
        child: Container(
          color: Colors.blue,
          child: CupertinoSlidingSegmentedControl(
            children: {
              0: Text("MCQ"),
              1: Text("True-False"),
              2: Text("Either"),
            },
            onValueChanged: changeQuestionType,
          ),
        ),
      );
    }

    Widget startQuizButton = MaterialButton(
      onPressed: startQuiz,
      color: Colors.pink,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Text("Let's GO!"),
    );

    return Material(
      color: Colors.grey.shade100,
      child: Scaffold(
        floatingActionButton: startQuizButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.vertical,
          children: [
            Flexible(
              flex: 1,
              child: countCounter(),
            ),
            Flexible(
              flex: 1,
              child: questionDifficultyContainer(),
            ),
            Flexible(
              flex: 1,
              child: questionTypeContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
