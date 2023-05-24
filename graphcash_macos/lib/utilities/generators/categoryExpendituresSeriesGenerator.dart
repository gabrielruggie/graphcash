import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/utilities/abstract_classes/objectGenerator.dart';
import 'package:graphcash_macos/charts/series/categoryExpenditureSeries.dart';

class CategoryExpendituresSeriesGenerator
    implements ObjectGenerator<CategoryExpenditureSeries> {
  List<List<dynamic>> csvData = [];

  CategoryExpendituresSeriesGenerator({required this.csvData});

  @override
  List<CategoryExpenditureSeries> generateSeriesList() {
    List<CategoryExpenditureSeries> objects = <CategoryExpenditureSeries>[];

    print(csvData);
    // Start at 1 to ignore header content
    for (int i = 0; i < csvData.length; i++) {
      // May want to put the index numbers in a .env file as well
      CategoryExpenditureSeries series = CategoryExpenditureSeries(
          totalAmount: csvData[i][2],
          categoryName: csvData[i][3],
          barColor: charts.ColorUtil.fromDartColor(Colors.purple));

      objects.add(series);
    }

    return objects;
  }
}
