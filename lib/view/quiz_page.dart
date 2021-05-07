import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/model/question.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/service/question_service_provider.dart';
import 'package:quiz/widget/question_widget.dart';

class QuizPage extends StatelessWidget {
  static Route<dynamic> route(QuizParameter quizParameter) =>
      MaterialPageRoute(builder: (_) => QuizPage(quizParameter));

  final QuizParameter _quizParameter;

  const QuizPage(this._quizParameter);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionServiceProvider>(
      create: (_) => QuestionServiceProvider(),
      builder: (context, child) {
        QuestionServiceProvider questionService =
            Provider.of<QuestionServiceProvider>(context);
        List<Question> questions = questionService.questions;

        if (questions == null) {
          questionService.fetchQuestion(_quizParameter);

          return Center(
            child: CircularProgressIndicator(),
          );
        }

        int i = 0;

        while (true) {
          if (i == questions.length) {
            break;
          } else {
            return StatefulBuilder(builder: (context, setstate) {
              Question question = questions[i];
              QuestionWidget questionWidget;

              setstate(() {
                questionWidget = QuestionWidget(question: question);
              });

              return Material(
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(child: questionWidget),
                        ElevatedButton(
                          onPressed: () {
                            setstate(() {
                              ++i;
                            });
                          },
                          child: Text("Next"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          }
        }

        return Container();
      },
    );
  }
}
