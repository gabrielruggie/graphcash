import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/utilities/abstract_classes/objectGenerator.dart';
import 'package:graphcash_macos/charts/series/expenditureProgressionSeries.dart';

class ExpenditureProgressionSeriesGenerator
    implements ObjectGenerator<ExpenditureProgressionSeries> {
  List<List<dynamic>> csvData = [];

  ExpenditureProgressionSeriesGenerator({required this.csvData});

  @override
  List<ExpenditureProgressionSeries> generateSeriesList() {
    List<ExpenditureProgressionSeries> objects =
        <ExpenditureProgressionSeries>[];

    for (int i = 1; i < csvData.length; i++) {
      ExpenditureProgressionSeries series = ExpenditureProgressionSeries(
          budgetRemaining: csvData[i][4],
          dayNum: csvData[i][1],
          barColor: charts.ColorUtil.fromDartColor(Colors.purple));

      objects.add(series);
    }

    return objects;
  }

  List<ExpenditureProgressionSeries> generateIdealSeriesList() {
    List<ExpenditureProgressionSeries> objects =
        <ExpenditureProgressionSeries>[];

    ExpenditureProgressionSeries startSeries = ExpenditureProgressionSeries(
        budgetRemaining: csvData[0][4],
        dayNum: 1,
        barColor: charts.ColorUtil.fromDartColor(
            const Color.fromARGB(255, 76, 195, 251)));

    ExpenditureProgressionSeries endSeries = ExpenditureProgressionSeries(
        budgetRemaining: 0,
        dayNum: csvData[0][1],
        barColor: charts.ColorUtil.fromDartColor(
            const Color.fromARGB(255, 76, 195, 251)));

    objects.add(startSeries);
    objects.add(endSeries);

    return objects;
  }
}
