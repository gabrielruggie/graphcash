import 'package:charts_flutter/flutter.dart' as charts;

class ExpenditureProgressionSeries {
  final int budgetRemaining;
  final int dayNum;
  final charts.Color barColor;

  ExpenditureProgressionSeries(
      {required this.budgetRemaining,
      required this.dayNum,
      required this.barColor});
}
