import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/utilities/abstract_classes/objectGenerator.dart';
import 'package:graphcash_macos/charts/series/averageDailyExpenditureProgressionSeries.dart';

class AverageDailyExpendituresSeriesGenerator
    implements ObjectGenerator<AverageDailyExpenditureProgressionSeries> {
  List<List<dynamic>> csvData = [];

  AverageDailyExpendituresSeriesGenerator({required this.csvData});

  // Again, will need to be refined so that amountSpent is really amountSpent on day number = dayNum
  @override
  List<AverageDailyExpenditureProgressionSeries> generateSeriesList() {
    List<AverageDailyExpenditureProgressionSeries> objects =
        <AverageDailyExpenditureProgressionSeries>[];

    for (int i = 1; i < csvData.length; i++) {
      AverageDailyExpenditureProgressionSeries series =
          AverageDailyExpenditureProgressionSeries(
              amountSpent: csvData[i][2],
              dayNum: csvData[i][1],
              barColor: charts.ColorUtil.fromDartColor(Colors.purple));

      objects.add(series);
    }
    return objects;
  }

  List<AverageDailyExpenditureProgressionSeries> generateIdealSeriesList() {
    List<AverageDailyExpenditureProgressionSeries> objects =
        <AverageDailyExpenditureProgressionSeries>[];

    AverageDailyExpenditureProgressionSeries startSeries =
        AverageDailyExpenditureProgressionSeries(
      // Total Budget Amount / Total Days For Budget
      amountSpent: (csvData[0][4] / csvData[0][1]).round(),
      dayNum: 0,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromARGB(255, 76, 195, 251)),
    );
    AverageDailyExpenditureProgressionSeries endSeries =
        AverageDailyExpenditureProgressionSeries(
      amountSpent: (csvData[0][4] / csvData[0][1]).round(),
      dayNum: csvData[0][1],
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromARGB(255, 76, 195, 251)),
    );

    objects.add(startSeries);
    objects.add(endSeries);

    return objects;
  }
}
