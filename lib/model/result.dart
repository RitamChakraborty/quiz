import 'package:meta/meta.dart';

class Result {
  final int _marksObtained;
  final int _totalMarks;

  Result({
    @required int marksObtained,
    @required int totalMarks,
  })  : this._marksObtained = marksObtained,
        this._totalMarks = totalMarks,
        assert(marksObtained != null),
        assert(totalMarks != null);

  int get totalMarks => _totalMarks;

  int get marksObtained => _marksObtained;

  double get percentage => ((_marksObtained / _totalMarks) * 100);

  String get percentageText => percentage.toStringAsFixed(1) + "%";

  String get comment {
    if (percentage == 100) {
      return "Congratulations!";
    } else if (percentage > 90 && percentage < 100) {
      return "Very Well Done!";
    } else if (percentage > 80 && percentage <= 90) {
      return "Great Job!";
    } else if (percentage > 70 && percentage <= 80) {
      return "Well Played!";
    } else if (percentage > 60 && percentage <= 70) {
      return "Good";
    } else if (percentage > 50 && percentage <= 60) {
      return "Satisfactory";
    } else if (percentage > 40 && percentage <= 50) {
      return "Fine";
    } else if (percentage > 30 && percentage <= 40) {
      return "Marginal";
    } else if (percentage > 20 && percentage <= 30) {
      return "Not good enough";
    } else if (percentage > 10 && percentage <= 20) {
      return "Try harder next time";
    } else if (percentage > 0 && percentage <= 10) {
      return "You can do better!";
    } else if (percentage == 0) {
      return "Better luck next time";
    }

    return "";
  }
}
