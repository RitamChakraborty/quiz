import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  static Route<dynamic> route(
          {@required int score, @required int count, Key key}) =>
      MaterialPageRoute(builder: (_) => ScorePage(score: score, count: count));

  final int _score;
  final int _count;

  const ScorePage({@required int score, @required int count, Key key})
      : this._score = score,
        this._count = count,
        assert(score != null),
        assert(count != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: Text("$_score/$_count"),
        ),
      ),
    );
  }
}
