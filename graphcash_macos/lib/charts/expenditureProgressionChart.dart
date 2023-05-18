import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/charts/series/expenditureProgressionSeries.dart';

class ExpenditureProgressionChart extends StatelessWidget {
  final List<ExpenditureProgressionSeries> data;

  ExpenditureProgressionChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ExpenditureProgressionSeries, num>> series = [
      charts.Series(
          id: "Category Expenditures",
          data: data,
          domainFn: (ExpenditureProgressionSeries series, _) =>
              series.budgetRemaining,
          measureFn: (ExpenditureProgressionSeries series, _) => series.dayNum,
          colorFn: (ExpenditureProgressionSeries series, _) => series.barColor)
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
                child: charts.LineChart(series,
                    domainAxis: const charts.NumericAxisSpec(
                      tickProviderSpec:
                          charts.BasicNumericTickProviderSpec(zeroBound: false),
                      viewport: charts.NumericExtents(2016.0, 2022.0),
                    ),
                    animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
