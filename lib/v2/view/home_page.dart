import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/v2/service/quiz_service.dart';

class HomePage extends StatelessWidget {
  final QuizService _quizService = QuizService();

  @override
  Widget build(BuildContext context) {
    List<String> categories = _quizService.categories;

    Widget categoryTile({@required String title}) => Container(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 10,
            child: Container(
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
        );

    double getMaxCrossAxisExtend() {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      Size size = mediaQueryData.size;

      if (size.height > size.width) {
        return mediaQueryData.size.width / 1.5;
      } else {
        return mediaQueryData.size.height / 2.5;
      }
    }

    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) =>
              categoryTile(title: categories[index]),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: getMaxCrossAxisExtend(),
            childAspectRatio: 1,
          ),
        ),
      ),
    );
  }
}
