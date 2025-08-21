import 'package:flutter/material.dart';

enum ChartRangeType { week, month, year }

ChartRangeType getRangeType(DateTimeRange range) {
  final days = range.end.difference(range.start).inDays + 1;

  if (days <= 7) {
    return ChartRangeType.week;
  } else if (days <= 31 &&
      range.start.month == range.end.month &&
      range.start.year == range.end.year) {
    return ChartRangeType.month;
  } else {
    return ChartRangeType.year;
  }
}
