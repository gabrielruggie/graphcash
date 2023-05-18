import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/charts/series/categoryExpenditureSeries.dart';

class CategoryExpenditureChart extends StatelessWidget {
  final List<CategoryExpenditureSeries> data;

  CategoryExpenditureChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CategoryExpenditureSeries, String>> series = [
      charts.Series(
          id: "Category Expenditures",
          data: data,
          domainFn: (CategoryExpenditureSeries series, _) =>
              series.categoryName,
          measureFn: (CategoryExpenditureSeries series, _) =>
              series.totalAmount,
          colorFn: (CategoryExpenditureSeries series, _) => series.barColor)
    ];

    return Container(
      width: 450,
      height: 450,
      padding: const EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Total Expenditures Per Declared Category",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Expanded(
                child: charts.PieChart<String>(series,
                    defaultRenderer: charts.ArcRendererConfig(
                        arcRendererDecorators: [
                          charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ]),
                    animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
