import 'package:charts_flutter/flutter.dart' as charts;

class AverageDailyExpenditureProgressionSeries {
  final int amountSpent;
  final int dayNum;
  final charts.Color barColor;

  AverageDailyExpenditureProgressionSeries(
      {required this.amountSpent,
      required this.dayNum,
      required this.barColor});
}
