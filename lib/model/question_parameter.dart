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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this._amount;
    data['category'] = this._category;
    data['difficulty'] = this._difficulty;
    data['type'] = this._type;
    return data;
  }

  @override
  String toString() {
    return API +
        "?amount=$_amount" +
        "${_category == 0 ? "" : "&category=" + _category.toString()}" +
        "${_difficulty == "" ? "" : "&difficulty=" + difficulty}" +
        "${_type == "" ? "" : "&type=" + type}";
  }
}
