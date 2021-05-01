import 'package:meta/meta.dart';

class QuizParameter {
  static const API = "https://opentdb.com/api.php";
  final int _amount;
  final int _category;
  final String _difficulty;
  final String _type;

  const QuizParameter(
      {@required int amount, int category, String difficulty, String type})
      : this._amount = amount,
        this._category = category,
        this._difficulty = difficulty,
        this._type = type,
        assert(amount != null);

  String get type => _type;

  String get difficulty => _difficulty;

  int get category => _category;

  int get amount => _amount;

  @override
  String toString() {
    return API +
        "?amount=$_amount" +
        "${_category == null ? "" : "&category=" + _category.toString()}" +
        "${_difficulty == null ? "" : "&difficulty=" + difficulty}" +
        "${_type == null ? "" : "&type=" + type}";
  }
}
