import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:graphcash_macos/components/mainMenuBtn.dart';
import 'package:graphcash_macos/charts/series/categoryExpenditureSeries.dart';
import 'package:graphcash_macos/charts/catergoryExpenditureChart.dart';
import 'package:graphcash_macos/charts/series/expenditureProgressionSeries.dart';
import 'package:graphcash_macos/charts/expenditureProgressionChart.dart';
import 'package:graphcash_macos/charts/averageDailyExpenditureProgressionChart.dart';
import 'package:graphcash_macos/charts/series/averageDailyExpenditureProgressionSeries.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExpenditureProgressionSeries> exps = [
    ExpenditureProgressionSeries(
      budgetRemaining: 590,
      dayNum: 1,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ExpenditureProgressionSeries(
      budgetRemaining: 500,
      dayNum: 2,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ExpenditureProgressionSeries(
      budgetRemaining: 445,
      dayNum: 3,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    ExpenditureProgressionSeries(
      budgetRemaining: 410,
      dayNum: 4,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  final List<ExpenditureProgressionSeries> exps1 = [
    ExpenditureProgressionSeries(
      budgetRemaining: 600,
      dayNum: 1,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    ExpenditureProgressionSeries(
      budgetRemaining: 0,
      dayNum: 30,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    )
  ];

  // Actual Spending Curve
  List<AverageDailyExpenditureProgressionSeries> avg = [
    AverageDailyExpenditureProgressionSeries(
      amountSpent: 15,
      dayNum: 1,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    AverageDailyExpenditureProgressionSeries(
      amountSpent: 24,
      dayNum: 2,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    AverageDailyExpenditureProgressionSeries(
      amountSpent: 26,
      dayNum: 3,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    AverageDailyExpenditureProgressionSeries(
      amountSpent: 10,
      dayNum: 4,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  // Ideal Average Spending Curve
  final List<AverageDailyExpenditureProgressionSeries> avg1 = [
    AverageDailyExpenditureProgressionSeries(
      amountSpent: 20,
      dayNum: 0,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    AverageDailyExpenditureProgressionSeries(
      amountSpent: 20,
      dayNum: 30,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    )
  ];

  final List<CategoryExpenditureSeries> ctgExps = [
    CategoryExpenditureSeries(
      categoryName: "Groceries",
      totalAmount: 100,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    CategoryExpenditureSeries(
      categoryName: "Bars",
      totalAmount: 200,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    CategoryExpenditureSeries(
      categoryName: "Fast Food",
      totalAmount: 300,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
    CategoryExpenditureSeries(
      categoryName: "Clothes",
      totalAmount: 400,
      barColor: charts.ColorUtil.fromDartColor(Colors.purple),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 50, 50, 50),
          title: const Text(
            "Graph Cash",
            style: TextStyle(fontSize: 40),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 37, 37, 37),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 500,
                child: Row(
                  children: <Widget>[
                    CategoryExpenditureChart(
                      data: ctgExps,
                    ),
                    ExpenditureProgressionChart(
                      data: exps,
                      data2: exps1,
                    ),
                    AverageDailyExpenditureProgressionChart(
                        data: avg, data2: avg1)
                  ],
                ),
              ),
              Container(
                height: 200,
                color: const Color.fromARGB(255, 33, 33, 33),
                child: ButtonBar(
                  //constraints: const BoxConstraints(maxWidth: 200),
                  mainAxisSize: MainAxisSize.max,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MenuButton(
                      height: 75,
                      width: 200,
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 76, 195, 251),
                          Color.fromARGB(255, 28, 153, 243)
                        ],
                      ),
                      onPressed: () {},
                      child: const Text(
                        'New Project',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MenuButton(
                      height: 75,
                      width: 200,
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 28, 153, 243),
                          Color.fromARGB(255, 152, 46, 252)
                        ],
                      ),
                      onPressed: () {},
                      child: const Text(
                        'New Transaction',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MenuButton(
                      height: 75,
                      width: 200,
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 167, 57, 207),
                          Color.fromARGB(255, 118, 19, 205)
                        ],
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Generate Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
