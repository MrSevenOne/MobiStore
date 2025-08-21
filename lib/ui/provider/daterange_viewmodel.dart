import 'package:flutter/material.dart';

class DaterangeViewmodel extends ChangeNotifier {
  DateTimeRange? _range;

  DaterangeViewmodel() {
    final now = DateTime.now();
    _range = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: now,
    );
  }

  DateTimeRange get range => _range!;

  void setRange(DateTimeRange newRange) {
    _range = newRange;
    notifyListeners();
  }
}
