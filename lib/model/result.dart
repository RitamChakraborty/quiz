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
}
