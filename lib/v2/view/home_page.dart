import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz/v2/service/quiz_service.dart';
import 'package:quiz/v2/widget/feeling_lucky_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final QuizService _quizService = QuizService();

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
    List<String> categories = _quizService.categories;

    // Functions

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
      print("I'm Feeling Lucky");
    };

    /// Start quiz when any category is pressed
    void categoryTileOnPressed() {}

    // Widgets
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
              child: MaterialButton(
                onPressed: categoryTileOnPressed,
                color: Colors.black26,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: Text(
                      "${title.toUpperCase()}",
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
        );

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
                categoryTile(title: categories[index]),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: getMaxCrossAxisExtend(),
              childAspectRatio: 1,
            ),
          ),
        ),
      ),
    ));
  }
}
