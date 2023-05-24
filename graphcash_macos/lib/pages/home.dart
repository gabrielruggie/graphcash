import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
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
  List<CategoryExpenditureSeries> ctgExps = [];

  void loadData() async {
    String csvString = await rootBundle.loadString("assets/test.csv");
    List<List<dynamic>> dataList =
        const CsvToListConverter().convert(csvString, eol: "\n");

    List<CategoryExpenditureSeries> objects = <CategoryExpenditureSeries>[];

    print(dataList);
    // Start at 1 to ignore header content
    for (int i = 0; i < dataList.length; i++) {
      // May want to put the index numbers in a .env file as well
      CategoryExpenditureSeries series = CategoryExpenditureSeries(
          totalAmount: dataList[i][2],
          categoryName: dataList[i][3],
          barColor: charts.ColorUtil.fromDartColor(Colors.purple));

      objects.add(series);
    }
    // Make writing to the CSV change the state as well
    setState(() {
      ctgExps = objects;
    });
  }

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
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromARGB(255, 76, 195, 251)),
    ),
    ExpenditureProgressionSeries(
      budgetRemaining: 0,
      dayNum: 30,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromARGB(255, 76, 195, 251)),
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
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromARGB(255, 76, 195, 251)),
    ),
    AverageDailyExpenditureProgressionSeries(
      amountSpent: 20,
      dayNum: 30,
      barColor: charts.ColorUtil.fromDartColor(
          const Color.fromARGB(255, 76, 195, 251)),
    )
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
                      onPressed: () async {
                        loadData();
                      },
                      child: const Text(
                        'Refresh',
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
