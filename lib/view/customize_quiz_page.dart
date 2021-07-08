import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:quiz/animation/bouncing_animation.dart';
import 'package:quiz/model/question_difficulty.dart';
import 'package:quiz/service/quiz_customizer_cubit.dart';
import 'package:quiz/view/quiz_page.dart';
import 'package:quiz/widget/start_quiz_button.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CustomizeQuizPage extends StatelessWidget {
  static const routeName = "/customizeQuizPage";

  @override
  Widget build(BuildContext context) {
    QuizCustomizerCubit quizCustomizer =
        BlocProvider.of<QuizCustomizerCubit>(context);
    Size size = MediaQuery.of(context).size;

    void changeQuestionCount(double value) {
      quizCustomizer.changeQuestionCount(value.toInt());
    }

    void changeDifficulty(QuestionDifficulty questionDifficulty) {
      quizCustomizer.changeDifficulty(questionDifficulty);
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
            appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
              progressBarColor: Theme.of(context).accentColor,
              trackColor: Theme.of(context).primaryColor,
            )),
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

    final selectedMargin = const EdgeInsets.all(4.0);

    final unselectedMargin = const EdgeInsets.all(12.0);

    Widget difficultyButton(
        QuestionDifficulty questionDifficulty, String difficulty) {
      return Expanded(
        child: GestureDetector(
          onTap: () => changeDifficulty(questionDifficulty),
          child: AspectRatio(
            aspectRatio: size.width / size.height,
            child: AnimatedContainer(
              margin: questionDifficulty == quizCustomizer.difficulty
                  ? selectedMargin
                  : unselectedMargin,
              duration: Duration(milliseconds: 400),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.8),
                    Theme.of(context).accentColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget questionDifficultyContainer() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              difficultyButton(QuestionDifficulty.EASY, "Easy"),
              difficultyButton(QuestionDifficulty.MEDIUM, "Medium"),
              difficultyButton(QuestionDifficulty.HARD, "Hard"),
              difficultyButton(QuestionDifficulty.ANY, "Mixed"),
            ],
          ),
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
          padding: const EdgeInsets.only(top: 32, bottom: 16),
          child: MaterialSegmentedControl(
            selectionIndex: quizCustomizer.questionTypeIndex,
            selectedColor: Theme.of(context).primaryColor,
            unselectedColor: Theme.of(context).backgroundColor,
            borderRadius: 0,
            verticalOffset: 16,
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

    Widget nextPageButton() {
      Size size = MediaQuery.of(context).size;
      double height = 40;

      return StatefulBuilder(
        builder: (context, setState) {
          if (height >= size.height / 2) {
            print('here');
            WidgetsFlutterBinding.ensureInitialized()
                .addPostFrameCallback((timeStamp) {
              startQuiz();
            });
          }

          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: size.width,
            height: height,
            child: CustomPaint(
              painter: StartQuizButton(),
              child: BouncingAnimation(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    double y = -details.localPosition.dy;

                    setState(() {
                      height = y > 40 ? y : 40;
                    });
                  },
                  onVerticalDragEnd: (details) {
                    setState(() {
                      while (height > 40) {
                        --height;
                      }
                    });
                  },
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: Colors.white,
                    ),
                    onPressed: startQuiz,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

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
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      countCounter(),
                      questionDifficultyContainer(),
                      questionTypeContainer(),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: nextPageButton(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
