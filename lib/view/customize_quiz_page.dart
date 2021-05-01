import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/service/quiz_customizer_cubit.dart';
import 'package:quiz/view/quiz_page.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CustomizeQuizPage extends StatelessWidget {
  static Route<dynamic> router() =>
      MaterialPageRoute(builder: (_) => CustomizeQuizPage());

  @override
  Widget build(BuildContext context) {
    QuizCustomizerCubit quizCustomizer =
        BlocProvider.of<QuizCustomizerCubit>(context);

    /// Change question count
    void changeQuestionCount(double value) {
      quizCustomizer.changeQuestionCount(value.toInt());
    }

    /// Change the difficulty of the questions
    void changeDifficulty(int index) {
      quizCustomizer.changeDifficulty(index);
    }

    /// Change question type
    void changeQuestionType(dynamic value) {
      quizCustomizer.changeQuestionType(value as int);
    }

    /// Start the quiz by navigating to the quiz page
    void startQuiz() {
      quizCustomizer.startQuiz();
    }

    // Widgets
    Widget countCounter() {
      return Expanded(
        child: Container(
          color: Colors.red,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(),
                  initialValue: 10.0,
                  min: 1,
                  max: 50,
                  onChange: changeQuestionCount,
                  innerWidget: (value) {
                    return Container();
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(16),
                  child: Text("${quizCustomizer.questionCount}"),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final selectedBoxShadow = BoxShadow(
      color: Colors.grey.shade300,
      offset: const Offset(8, 8),
      blurRadius: 5,
      spreadRadius: 3,
    );

    final unselectedBoxShadow = BoxShadow(
      color: Colors.grey.shade400,
      offset: const Offset(6, 6),
      blurRadius: 4,
      spreadRadius: 3,
    );

    final selectedMargin = const EdgeInsets.all(4.0);

    final unselectedMargin = const EdgeInsets.all(8.0);

    Widget difficultyButton(int index, String difficulty) {
      return Expanded(
        child: GestureDetector(
          onTap: () => changeDifficulty(index),
          child: AnimatedContainer(
            margin: index == quizCustomizer.difficultyIndex
                ? selectedMargin
                : unselectedMargin,
            duration: Duration(milliseconds: 400),
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green,
              boxShadow: [
                index == quizCustomizer.difficultyIndex
                    ? selectedBoxShadow
                    : unselectedBoxShadow
              ],
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
              difficultyButton(0, "Easy"),
              difficultyButton(1, "Medium"),
              difficultyButton(2, "Hard"),
              difficultyButton(3, "Mixed"),
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

    return BlocConsumer<QuizCustomizerCubit, AbstractQuizCustomizerState>(
      bloc: quizCustomizer,
      listener: (context, state) {
        if (state.runtimeType == StartQuizState) {
          Navigator.of(context)
              .push(QuizPage.route(quizCustomizer.quizParameter));
        }
      },
      builder: (context, state) {
        return Material(
          color: Colors.grey.shade100,
          child: Scaffold(
            floatingActionButton: startQuizButton,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  countCounter(),
                  questionDifficultyContainer(),
                  questionTypeContainer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
