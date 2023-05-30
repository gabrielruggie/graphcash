import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class GraphCashFileScanner {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/test.csv');
  }

  Future<List<List<dynamic>>> get fileContents async {
    File file = await localFile;
    String csvString = await file.readAsString();

    List<List<dynamic>> dataList =
        const CsvToListConverter().convert(csvString, eol: "\n");

    return dataList;
  }

  Future<File> writeToFile(GraphCashDataObject obj) async {
    try {
      File file = await localFile;
      List<List<dynamic>> data = await fileContents;

      List<dynamic> newRow = <dynamic>[];
      newRow.add(obj.transactionName);
      newRow.add(obj.dayNum);
      newRow.add(obj.transactionAmt);
      newRow.add(obj.categoryName);
      newRow.add(obj.budgetRemaining);

      data.add(newRow);

      String csv = const ListToCsvConverter().convert(data);

      return file.writeAsString(csv);
    } catch (e) {
      throw new FormatException("There was an error writing to file");
    }
  }

  Future<File> writeNewFile(GraphCashDataObject obj) async {
    try {
      File file = await localFile;

      // Called when creating a new file. Adds the header information to the top of the CSV
      List<dynamic> header = <dynamic>[];
      header.add(obj.transactionName);
      header.add(obj.dayNum);
      header.add(obj.transactionAmt);
      header.add(obj.categoryName);
      header.add(obj.budgetRemaining);

      String csv = const ListToCsvConverter().convert([header]);

      return file.writeAsString(csv);
    } catch (e) {
      throw new FormatException("There was an error writing to file");
    }
  }

  // dayNum comes from some calendar or count down ==> datetime library
  void createNewTransaction(String name, String dayNum, String amount,
      String category, String budgetAmountRemaining) {
    var v = GraphCashDataObject(
        transactionName: name,
        dayNum: dayNum,
        transactionAmt: amount,
        categoryName: category,
        budgetRemaining: budgetAmountRemaining);

    writeToFile(v);
  }

  void createNewProject(String dayNum, String budget) {
    var v = GraphCashDataObject.header(dayNum: dayNum, budgetRemaining: budget);

    writeNewFile(v);
  }
}

class GraphCashDataObject {
  final String transactionName;
  final String dayNum;
  final String transactionAmt;
  final String categoryName;
  final String budgetRemaining;

  GraphCashDataObject(
      {required this.transactionName,
      required this.dayNum,
      required this.transactionAmt,
      required this.categoryName,
      required this.budgetRemaining});

  GraphCashDataObject.header(
      {this.transactionName = "name",
      required this.dayNum,
      this.transactionAmt = "0",
      this.categoryName = "category",
      required this.budgetRemaining});
}
