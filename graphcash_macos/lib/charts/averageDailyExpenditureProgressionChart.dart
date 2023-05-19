import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/charts/series/averageDailyExpenditureProgressionSeries.dart';

class AverageDailyExpenditureProgressionChart extends StatelessWidget {
  final List<AverageDailyExpenditureProgressionSeries> data;
  final List<AverageDailyExpenditureProgressionSeries> data2;

  AverageDailyExpenditureProgressionChart(
      {required this.data, required this.data2});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<AverageDailyExpenditureProgressionSeries, num>> series =
        [
      charts.Series(
          id: "Category Expenditures",
          data: data,
          // X Axis
          domainFn: (AverageDailyExpenditureProgressionSeries series, _) =>
              series.dayNum,
          // Y Axis
          measureFn: (AverageDailyExpenditureProgressionSeries series, _) =>
              series.amountSpent,
          colorFn: (AverageDailyExpenditureProgressionSeries series, _) =>
              series.barColor),
      charts.Series(
          id: "Category Expenditures1",
          data: data2,
          // X Axis
          domainFn: (AverageDailyExpenditureProgressionSeries series, _) =>
              series.dayNum,
          // Y Axis
          measureFn: (AverageDailyExpenditureProgressionSeries series, _) =>
              series.amountSpent,
          colorFn: (AverageDailyExpenditureProgressionSeries series, _) =>
              series.barColor),
    ];

    return Container(
      width: 450,
      height: 450,
      padding: const EdgeInsets.all(25),
      child: Card(
        color: Color.fromARGB(255, 44, 44, 44),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              const Text(
                "Actual VS Ideal - Average Daily Spending",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Expanded(
                child: charts.LineChart(series,
                    domainAxis: const charts.NumericAxisSpec(
                      renderSpec: charts.GridlineRendererSpec(
                          labelStyle:
                              charts.TextStyleSpec(color: charts.Color.white),
                          lineStyle:
                              charts.LineStyleSpec(color: charts.Color.white)),
                      tickProviderSpec:
                          charts.BasicNumericTickProviderSpec(zeroBound: false),
                      viewport: charts.NumericExtents(
                          1, 30), // <== Changes X Axis bounds
                    ),
                    primaryMeasureAxis: const charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                            labelStyle:
                                charts.TextStyleSpec(color: charts.Color.white),
                            lineStyle: charts.LineStyleSpec(
                                color: charts.Color.white))),
                    animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
