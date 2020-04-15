import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/model/question.dart';
import 'package:quiz/pages/result_page.dart';
import 'package:quiz/widgets/overlay_widget.dart';

/// QuizPage shows every questions
///
/// [_url] is provided by homepage
/// To get specific type of questions
class QuizPage extends StatefulWidget {
  final String _url;

  const QuizPage({@required String url})
      : this._url = url,
        assert(url != null);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /// [List] of [Question]
  List<Question> questions;

  /// Track the score
  int score;

  /// [Stream] of [questions]
  Stream<List<Question>> stream;

  /// Initialize [HtmlUnescape]
  final HtmlUnescape unescape = HtmlUnescape();

  /// Track current questionIndex
  int questionIndex;

  /// If `true` then [overLayWidget] will be visible
  bool overlayVisible;

  /// If `true` then answer is correct
  bool correct;

  /// Returns [questions] asynchronously
  Future<List<Question>> getQuestions() async {
    /// Get the [Question] as a `JSON`
    var res = await http.get(widget._url);

    /// Parse `JSON` to [Map]
    var data = json.decode(res.body);

    /// If `response_code` is not `0`
    /// Then there is some problem getting the [questions]
    if (data['response_code'] == 0) {
      /// Iterate over every [Question]
      /// And convert `HTML Utils`
      for (var i in data['results']) {
        String category = unescape.convert(i['category']);
        String question = unescape.convert(i['question']);
        String correctAnswer = unescape.convert(i['correct_answer']);

        /// [List] of all the choices for the [question]
        /// First add the correct answer to the list
        List<String> choices = [correctAnswer];

        /// Iterate over every incorrect choices
        for (var j in i['incorrect_answers']) {
          choices.add(unescape.convert(j));
        }

        /// Shuffle the choices
        /// Thus first answer is not the correct
        /// All the time
        choices.shuffle();

        /// Add the [Question] toe [questions]
        questions.add(Question(
            category: category,
            question: question,
            correctAnswer: correctAnswer,
            choices: choices));
      }
    }

    /// Shuffle the [questions]
    questions.shuffle();

    return questions;
  }

  @override
  void initState() {
    super.initState();

    /// Initialize local variables
    questions = [];
    score = 0;
    questionIndex = 0;
    overlayVisible = false;

    /// Get the [questions] as [Stream]
    stream = getQuestions().asStream();
  }

  @override
  Widget build(BuildContext context) {
    /// Returns the question as a [Card] with [Flex] `7`
    Widget questionWidget({String question}) {
      return Flexible(
        fit: FlexFit.loose,
        flex: 7,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  question,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      );
    }

    /// Returns every choice as a [Card] with [Flex] 2
    Widget choiceWidget({String choice, String correctAnswer}) => Flexible(
          fit: FlexFit.loose,
          flex: 2,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    choice,
                  ),
                ),
                onTap: () {
                  /// Rebuild the widget tree
                  /// If the choice is the correct answer
                  /// And increase [score]
                  /// Make the [overlayWidget] visible
                  setState(() {
                    if (choice == correctAnswer) {
                      ++score;
                      correct = true;
                    } else {
                      correct = false;
                    }
                    overlayVisible = true;
                  });
                },
              ),
            ),
          ),
        );

    /// Handle onTap event for [overLayWidget]
    overlayWidgetOnTap() {
      setState(() {
        /// When tapped make the [overlayWidget] invisible
        overlayVisible = false;

        /// If [questionIndex] is the last [Question] index
        /// Then navigate to next page
        /// Or show the next question
        if (questionIndex + 1 == questions.length) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResultPage(score: score, fullMarks: questions.length),
              ));
        } else {
          ++questionIndex;
        }
      });
    }

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              /// If finished fetching question then show the page
              /// Or show [LinearProgressIndicator]
              if (snapshot.hasData) {
                String question = questions[questionIndex].question;
                String correctAnswer = questions[questionIndex].correctAnswer;
                List<String> choices = questions[questionIndex].choices;

                /// Store all the widget to be shown
                /// In the [Column]
                List<Widget> children = [
                  /// Shows the progress
                  Flexible(
                    flex: 1,
                    child: LinearProgressIndicator(
                      value: questionIndex / questions.length,
                    ),
                  ),

                  /// Shows the question
                  questionWidget(question: question)
                ];

                /// Iterate over choices
                /// And add to [children]
                for (String choice in choices) {
                  children.add(choiceWidget(
                    choice: choice,
                    correctAnswer: correctAnswer,
                  ));
                }

                /// If [overlayVisible] is `true`
                /// Then show the [overlayWidget]
                /// Otherwise show a empty [Container]
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Flex(direction: Axis.vertical, children: children),
                    overlayVisible
                        ? OverlayWidget(
                            correct: correct,
                            correctAnswer: correctAnswer,
                            onTap: overlayWidgetOnTap)
                        : Container(),
                  ],
                );
              }

              return LinearProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
