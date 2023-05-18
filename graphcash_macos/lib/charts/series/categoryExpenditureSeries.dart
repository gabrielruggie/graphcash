import 'package:charts_flutter/flutter.dart' as charts;

class CategoryExpenditureSeries {
  final int totalAmount;
  final String categoryName;
  final charts.Color barColor;

  CategoryExpenditureSeries(
      {required this.totalAmount,
      required this.categoryName,
      required this.barColor});
}
