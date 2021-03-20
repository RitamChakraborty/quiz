import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/v2/service/quiz_service.dart';

class HomePage extends StatelessWidget {
  final QuizService _quizService = QuizService();

  @override
  Widget build(BuildContext context) {
    List<String> categories = _quizService.categories;

    Widget categoryTile({@required String title}) => Wrap(
          alignment: WrapAlignment.center,
          children: [
            Card(
              elevation: 10,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        Image.asset("assets/images/${title.toLowerCase()}.webp")
                            .image,
                  ),
                ),
              ),
            ),
          ],
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
