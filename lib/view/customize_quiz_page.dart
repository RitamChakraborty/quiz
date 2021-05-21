import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:quiz/service/quiz_customizer_cubit.dart';
import 'package:quiz/view/quiz_page.dart';
import 'package:quiz/widget/bouncing_animation.dart';
import 'package:quiz/widget/start_quiz_button.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CustomizeQuizPage extends StatelessWidget {
  static const routeName = "/customizeQuizPage";

  Widget nextPageButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.07,
      child: CustomPaint(
        painter: StartQuizButton(),
        child: Center(
          child: GestureDetector(
            onVerticalDragUpdate: (details) {},
            child: BouncingAnimation(
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_up_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(QuizPage.routeName);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    QuizCustomizerCubit quizCustomizer =
        BlocProvider.of<QuizCustomizerCubit>(context);

    void changeQuestionCount(double value) {
      quizCustomizer.changeQuestionCount(value.toInt());
    }

    void changeDifficulty(int index) {
      quizCustomizer.changeDifficulty(index);
    }

    void changeQuestionType(dynamic value) {
      quizCustomizer.changeQuestionType(value as int);
    }

    void startQuiz() {
      quizCustomizer.startQuiz();
    }

    Widget countCounter() {
      return Expanded(
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(16),
          child: SleekCircularSlider(
            appearance: CircularSliderAppearance(),
            initialValue: quizCustomizer.questionCount.toDouble(),
            min: 1,
            max: 50,
            onChange: changeQuestionCount,
            innerWidget: (value) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  "${quizCustomizer.questionCount}",
                  style: TextStyle(fontSize: 48),
                ),
              );
            },
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

    final selectedMargin = const EdgeInsets.all(8.0);

    final unselectedMargin = const EdgeInsets.all(16.0);

    Widget difficultyButton(int index, String difficulty) {
      return Expanded(
        child: GestureDetector(
          onTap: () => changeDifficulty(index),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: AnimatedContainer(
              margin: index == quizCustomizer.difficultyIndex
                  ? selectedMargin
                  : unselectedMargin,
              duration: Duration(milliseconds: 400),
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
        ),
      );
    }

    Widget questionDifficultyContainer() {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            difficultyButton(0, "Easy"),
            difficultyButton(1, "Medium"),
            difficultyButton(2, "Hard"),
            difficultyButton(3, "Mixed"),
          ],
        ),
      );
    }

    Widget segmentedSliderChild(String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          "$value",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    Widget questionTypeContainer() {
      return Expanded(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(16),
          child: MaterialSegmentedControl(
            selectionIndex: quizCustomizer.questionTypeIndex,
            borderColor: Colors.grey,
            selectedColor: Colors.purple,
            unselectedColor: Colors.grey.shade300,
            children: {
              0: segmentedSliderChild("MCQ"),
              1: segmentedSliderChild("True-False"),
              2: segmentedSliderChild("Either"),
            },
            onSegmentChosen: changeQuestionType,
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
          Navigator.of(context).pushNamed(
            QuizPage.routeName,
            arguments: quizCustomizer.quizParameter,
          );
        }
      },
      builder: (context, state) {
        return Material(
          color: Colors.grey.shade100,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
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
                  nextPageButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
