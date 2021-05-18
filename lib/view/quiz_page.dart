import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/model/question.dart';
import 'package:quiz/model/question_parameter.dart';
import 'package:quiz/model/result.dart';
import 'package:quiz/service/question_service_provider.dart';
import 'package:quiz/view/score_page.dart';
import 'package:quiz/widget/question_widget.dart';

class QuizPage extends StatelessWidget {
  static const routeName = "/quizPage";

  Widget questionCounter({
    @required int totalCount,
    @required int currentIndex,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: List<Widget>.generate(
          totalCount,
          (index) {
            Color color = index == currentIndex ? Colors.purple : Colors.grey;

            return Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 4,
                  color: color),
            );
          },
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QuizParameter quizParameter =
        ModalRoute.of(context).settings.arguments as QuizParameter;

    return ChangeNotifierProvider<QuestionServiceProvider>(
      create: (_) => QuestionServiceProvider(),
      builder: (context, child) {
        QuestionServiceProvider questionService =
            Provider.of<QuestionServiceProvider>(context);
        bool loading = questionService.loading;
        bool completed = questionService.completed;

        if (completed) {
          WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
            (timeStamp) {
              Navigator.of(context).pushNamed(
                ScorePage.routeName,
                arguments: Result(
                  marksObtained: questionService.score,
                  totalMarks: questionService.count,
                ),
              );
            },
          );

          return Container();
        }

        if (loading) {
          questionService.fetchQuestion(quizParameter);
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          Question question = questionService.question;
          QuestionWidget questionWidget = QuestionWidget(
            question: question,
            answer: questionService.answer,
          );

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: questionService.nextQuestion,
              child: Icon(Icons.navigate_next),
            ),
            body: SafeArea(
              child: Material(
                child: Column(
                  children: [
                    questionCounter(currentIndex: 3, totalCount: 10),
                    Expanded(
                      child: questionWidget,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
