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
        bool loading = questionService.loading;
        bool completed = questionService.completed;

        if (completed) {
          // Todo: Navigate to result page

          return Text("Done");
        }

        if (loading) {
          questionService.fetchQuestion(_quizParameter);
          return Center(child: CircularProgressIndicator());
        } else {
          Question question = questionService.question;
          QuestionWidget questionWidget = QuestionWidget(question: question);

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: questionService.nextQuestion,
              child: Icon(Icons.navigate_next),
            ),
            body: Material(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Expanded(child: questionWidget),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
