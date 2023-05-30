import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphcash_macos/utilities/graphCashFileScanner.dart';
import 'package:graphcash_macos/components/mainMenuBtn.dart';
import 'package:graphcash_macos/charts/series/categoryExpenditureSeries.dart';
import 'package:graphcash_macos/charts/catergoryExpenditureChart.dart';
import 'package:graphcash_macos/charts/series/expenditureProgressionSeries.dart';
import 'package:graphcash_macos/charts/expenditureProgressionChart.dart';
import 'package:graphcash_macos/charts/averageDailyExpenditureProgressionChart.dart';
import 'package:graphcash_macos/charts/series/averageDailyExpenditureProgressionSeries.dart';
import 'package:graphcash_macos/utilities/generators/categoryExpendituresSeriesGenerator.dart';
import 'package:graphcash_macos/utilities/generators/averageDailyExpendituresSeriesGenerator.dart';
import 'package:graphcash_macos/utilities/generators/expenditureProgressionSeriesGeneraotr.dart';

// When creating the write function, call the load data again to change the state of the lists
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryExpenditureSeries> ctgExps = [];
  List<AverageDailyExpenditureProgressionSeries> avgActual = [];
  List<AverageDailyExpenditureProgressionSeries> avgIdeal = [];
  List<ExpenditureProgressionSeries> expActual = [];
  List<ExpenditureProgressionSeries> expIdeal = [];

  // Remaining Budget that updates with every transaction
  int currentBalance = 0;

  final _transactionFormKey = GlobalKey<FormState>();
  final transactionNameController = TextEditingController();
  final transactionCategoryController = TextEditingController();
  final transactionAmountController = TextEditingController();

  final _projectFormKey = GlobalKey<FormState>();
  final projectDayNumController = TextEditingController();
  final projectBudgetAmtController = TextEditingController();

  void loadData() async {
    var scanner = GraphCashFileScanner();
    List<List<dynamic>> dataList = await scanner.fileContents;

    // budget value of last transaction. If none ==> gets header's value
    currentBalance = dataList.last[4];

    CategoryExpendituresSeriesGenerator ctgExpGenerator =
        CategoryExpendituresSeriesGenerator(csvData: dataList);
    List<CategoryExpenditureSeries> categoryExpenditureSeriesObjects =
        ctgExpGenerator.generateSeriesList();

    AverageDailyExpendituresSeriesGenerator avgGenerator =
        AverageDailyExpendituresSeriesGenerator(csvData: dataList);
    List<AverageDailyExpenditureProgressionSeries>
        actualAverageDailyExpendituresSeriesObjects =
        avgGenerator.generateSeriesList();
    List<AverageDailyExpenditureProgressionSeries>
        idealAverageDailyExpendituresSeriesObjects =
        avgGenerator.generateIdealSeriesList();

    ExpenditureProgressionSeriesGenerator expGenerator =
        ExpenditureProgressionSeriesGenerator(csvData: dataList);
    List<ExpenditureProgressionSeries> actualExpenditureSeriesObjects =
        expGenerator.generateSeriesList();
    List<ExpenditureProgressionSeries> idealExpenditureSeriesObjects =
        expGenerator.generateIdealSeriesList();

    setState(() {
      ctgExps = categoryExpenditureSeriesObjects;
      avgActual = actualAverageDailyExpendituresSeriesObjects;
      avgIdeal = idealAverageDailyExpendituresSeriesObjects;
      expActual = actualExpenditureSeriesObjects;
      expIdeal = idealExpenditureSeriesObjects;
    });
  }

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
                      actualData: expActual,
                      idealData: expIdeal,
                    ),
                    AverageDailyExpenditureProgressionChart(
                        actualData: avgActual, idealData: avgIdeal)
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 33, 33, 33),
                                scrollable: true,
                                title: const Text(
                                  'New Project',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _projectFormKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller: projectDayNumController,
                                          decoration: const InputDecoration(
                                            labelText: 'Duration (Days)',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            icon: Icon(Icons.catching_pokemon),
                                            iconColor: Colors.white,
                                          ),
                                        ),
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller:
                                              projectBudgetAmtController,
                                          decoration: const InputDecoration(
                                              labelText: 'Budget',
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              icon: Icon(Icons.attach_money),
                                              iconColor: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      child: const Text("Submit"),
                                      onPressed: () {
                                        GraphCashFileScanner scanner =
                                            GraphCashFileScanner();

                                        String projectDuration =
                                            projectDayNumController.text;
                                        String projectBudgetAmt =
                                            projectBudgetAmtController.text;

                                        scanner.createNewProject(
                                            projectDuration, projectBudgetAmt);

                                        var contents = scanner.fileContents;
                                        print(contents);
                                        // Close transaction window upon submission
                                        Navigator.of(context).pop();
                                      })
                                ],
                              );
                            });
                      },
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 33, 33, 33),
                                scrollable: true,
                                title: const Text(
                                  'New Transaction',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: _transactionFormKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller: transactionNameController,
                                          decoration: const InputDecoration(
                                              labelText: 'Name',
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              icon: Icon(Icons.badge),
                                              iconColor: Colors.white),
                                        ),
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller:
                                              transactionCategoryController,
                                          decoration: const InputDecoration(
                                            labelText: 'Category',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            icon: Icon(Icons.catching_pokemon),
                                            iconColor: Colors.white,
                                          ),
                                        ),
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller:
                                              transactionAmountController,
                                          decoration: const InputDecoration(
                                              labelText: 'Amount',
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              icon: Icon(Icons.attach_money),
                                              iconColor: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      child: const Text("Submit"),
                                      onPressed: () {
                                        GraphCashFileScanner scanner =
                                            GraphCashFileScanner();

                                        String transactionName =
                                            transactionNameController.text;
                                        String transactionAmt =
                                            transactionAmountController.text;
                                        String transactionCat =
                                            transactionCategoryController.text;

                                        int remainingBalance = currentBalance -
                                            int.parse(transactionAmt);
                                        scanner.createNewTransaction(
                                            transactionName,
                                            "4",
                                            transactionAmt,
                                            transactionCat.toLowerCase(),
                                            "$remainingBalance");

                                        var contents = scanner.fileContents;
                                        print(contents);
                                        // Close transaction window upon submission
                                        Navigator.of(context).pop();
                                      })
                                ],
                              );
                            });
                      },
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
