import 'package:flutter/material.dart';
import 'package:quiz/v2/service/quiz_service.dart';

class HomePage extends StatelessWidget {
  QuizService _quizService = QuizService();

  @override
  Widget build(BuildContext context) {
    List<String> categories = _quizService.categories;

    Widget categoryTile({@required String title}) => ListTile(
          title: Text(title),
        );

    return Material(
      child: Container(
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) =>
              categoryTile(title: categories[index]),
        ),
      ),
    );
  }
}
