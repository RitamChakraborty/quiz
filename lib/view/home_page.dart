import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/model/quiz_category.dart';
import 'package:quiz/service/quiz_customizer_cubit.dart';
import 'package:quiz/view/customize_quiz_page.dart';
import 'package:quiz/widget/feeling_lucky_button.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  AnimationController _animationController;

  bool _show = true;

  /// Listen to scroll direction
  /// And hide and show fab animation direction
  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_show) {
        _show = true;
        _animationController.forward();
      }
    } else {
      if (_show) {
        _show = false;
        _animationController.reverse();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _scrollController.addListener(_scrollListener);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuizCustomizerCubit quizCustomizer =
        BlocProvider.of<QuizCustomizerCubit>(context);
    List<QuestionCategory> categories = QuestionCategory.values
        .where((category) => category != QuestionCategory.ANY)
        .toList();

    /// Returns the MaxCrossAxisExtend value according to the orientation
    double getMaxCrossAxisExtend() {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      Size size = mediaQueryData.size;

      if (size.height > size.width) {
        return mediaQueryData.size.width / 1.5;
      } else {
        return mediaQueryData.size.height / 2.5;
      }
    }

    /// I'm Feeling Lucky button action
    final VoidCallback feelingLuckyButtonOnPressed = () {
      quizCustomizer.selectCategory(0);
    };

    // Widgets
    Widget categoryTile({@required int index}) => InkWell(
          onTap: () {
            quizCustomizer.selectCategory(index);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                            "assets/images/${categories[index].title.toLowerCase()}.webp")
                        .image,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                  child: FittedBox(
                    alignment: Alignment.bottomRight,
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 12, right: 8),
                        child: Text(
                          "${categories[index].title.toUpperCase()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

    return BlocConsumer<QuizCustomizerCubit, AbstractQuizCustomizerState>(
      bloc: quizCustomizer,
      listener: (context, state) {
        if (state.runtimeType == QuizCategoryChosenState) {
          Navigator.of(context).pushNamed(CustomizeQuizPage.routeName);
        }
      },
      builder: (context, state) {
        return Material(
          child: Scaffold(
            floatingActionButton: FeelingLuckyButton(
              onPressed: feelingLuckyButtonOnPressed,
              animationController: _animationController,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) =>
                      categoryTile(index: index),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: getMaxCrossAxisExtend(),
                    childAspectRatio: 1,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
