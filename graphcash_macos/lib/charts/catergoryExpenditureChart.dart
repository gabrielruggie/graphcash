import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:graphcash_macos/charts/series/categoryExpenditureSeries.dart';

class CategoryExpenditureChart extends StatefulWidget {
  final List<CategoryExpenditureSeries> data;
  const CategoryExpenditureChart({Key? key, required this.data})
      : super(key: key);

  @override
  State<CategoryExpenditureChart> createState() =>
      _CategoryExpenditureChartState();
}

// Try putting the load function higher up
class _CategoryExpenditureChartState extends State<CategoryExpenditureChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<CategoryExpenditureSeries, String>> series = [
      charts.Series(
          id: "Category Expenditures",
          data: widget.data,
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
        color: Color.fromARGB(255, 44, 44, 44),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              const Text(
                "Total Expenditures Per Category",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Expanded(
                child: charts.BarChart(series,
                    domainAxis: charts.AxisSpec<String>(
                      renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                              color: charts.Color.fromHex(code: "#5F5F5F")),
                          lineStyle: charts.LineStyleSpec(
                              color: charts.Color.fromHex(code: "#5F5F5F"))),
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
