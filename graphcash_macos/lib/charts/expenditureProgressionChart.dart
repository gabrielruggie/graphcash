import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/charts/series/expenditureProgressionSeries.dart';

class ExpenditureProgressionChart extends StatelessWidget {
  final List<ExpenditureProgressionSeries> data;
  final List<ExpenditureProgressionSeries> data2;

  ExpenditureProgressionChart({required this.data, required this.data2});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ExpenditureProgressionSeries, num>> series = [
      charts.Series(
          id: "Category Expenditures",
          data: data,
          // X Axis
          domainFn: (ExpenditureProgressionSeries series, _) => series.dayNum,
          // Y Axis
          measureFn: (ExpenditureProgressionSeries series, _) =>
              series.budgetRemaining,
          colorFn: (ExpenditureProgressionSeries series, _) => series.barColor),
      charts.Series(
          id: "Category Expenditures1",
          data: data2,
          // X Axis
          domainFn: (ExpenditureProgressionSeries series, _) => series.dayNum,
          // Y Axis
          measureFn: (ExpenditureProgressionSeries series, _) =>
              series.budgetRemaining,
          colorFn: (ExpenditureProgressionSeries series, _) => series.barColor),
    ];

    return Container(
      width: 450,
      height: 450,
      padding: const EdgeInsets.all(25),
      child: Card(
        color: const Color.fromARGB(255, 44, 44, 44),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              const Text(
                "Actual VS Ideal - Budget Progression",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Expanded(
                child: charts.LineChart(series,
                    domainAxis: charts.NumericAxisSpec(
                      renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                              color: charts.Color.fromHex(code: "#5F5F5F")),
                          lineStyle: charts.LineStyleSpec(
                              color: charts.Color.fromHex(code: "#5F5F5F"))),
                      tickProviderSpec:
                          charts.BasicNumericTickProviderSpec(zeroBound: false),
                      viewport: charts.NumericExtents(
                          1, 30), // <== Changes X Axis bounds
                    ),
                    primaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                            labelStyle: charts.TextStyleSpec(
                                color: charts.Color.fromHex(code: "#5F5F5F")),
                            lineStyle: charts.LineStyleSpec(
                                color: charts.Color.fromHex(code: "#5F5F5F")))),
                    animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
