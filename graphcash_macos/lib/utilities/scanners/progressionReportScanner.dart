import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/utilities/generics/fileScanner.dart';
import 'package:graphcash_macos/charts/series/expenditureProgressionSeries.dart';

// All problematic variables may end up in a common constant file
class ProgressionReportScanner
    extends FileScanner<ExpenditureProgressionSeries> {
  // might want to put path in .env file
  ProgressionReportScanner() : super(file: File('assets/test.csv'));

  // Reads Progression Report and retrieves actual progression data
  List<ExpenditureProgressionSeries> getActualData() {
    List<List<dynamic>> reportData = processCsv();
    List<ExpenditureProgressionSeries> objects =
        <ExpenditureProgressionSeries>[];

    // Start at 1 to ignore header content
    for (int i = 1; i < reportData.length; i++) {
      // May want to put the index numbers in a .env file as well
      ExpenditureProgressionSeries series = ExpenditureProgressionSeries(
          budgetRemaining: reportData[i][4],
          dayNum: reportData[i][1],
          barColor: charts.ColorUtil.fromDartColor(Colors.purple));

      objects.add(series);
    }

    return objects;
  }

  // Reads Progression Report Header and retrives ideal progression data
  List<ExpenditureProgressionSeries> getIdealData() {
    List<List<dynamic>> reportData = processCsv();
    List<ExpenditureProgressionSeries> objects =
        <ExpenditureProgressionSeries>[];

    ExpenditureProgressionSeries startPoint = ExpenditureProgressionSeries(
        budgetRemaining: reportData[0][4],
        dayNum: 1,
        barColor: charts.ColorUtil.fromDartColor(
            const Color.fromARGB(255, 76, 195, 251)));

    ExpenditureProgressionSeries endPoint = ExpenditureProgressionSeries(
        budgetRemaining: 0,
        dayNum: reportData[0][1],
        barColor: charts.ColorUtil.fromDartColor(
            const Color.fromARGB(255, 76, 195, 251)));

    objects.add(startPoint);
    objects.add(endPoint);

    return objects;
  }
}
