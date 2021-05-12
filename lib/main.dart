import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/service/quiz_customizer_cubit.dart';
import 'package:quiz/view/customize_quiz_page.dart';
import 'package:quiz/view/home_page.dart';
import 'package:quiz/view/quiz_page.dart';
import 'package:quiz/view/score_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: QuizCustomizerCubit(),
      child: MaterialApp(
        title: "Quiz",
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          CustomizeQuizPage.routeName: (context) => CustomizeQuizPage(),
          QuizPage.routeName: (context) => QuizPage(),
          ScorePage.routeName: (context) => ScorePage(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.grey,
          backgroundColor: Colors.grey[200],
        ),
      ),
    );
  }
}
