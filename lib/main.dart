import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/service/quiz_customizer_cubit.dart';
import 'package:quiz/view/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: QuizCustomizerCubit(),
      child: MaterialApp(
        title: "Quiz",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.grey,
          backgroundColor: Colors.grey[200],
        ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   backgroundColor: Colors.grey[800],
        //   buttonColor: Colors.grey,
        // ),
        home: HomePage(),
      ),
    );
  }
}
