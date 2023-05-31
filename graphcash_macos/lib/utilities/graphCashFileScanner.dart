import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class GraphCashFileScanner {
  Future<String> get _docDirPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _csvDataFile async {
    final path = await _docDirPath;
    return File('$path/test.csv');
  }

  Future<File> get _dateFile async {
    final path = await _docDirPath;
    return File('$path/dates.txt');
  }

  Future<String> get dateFileContents async {
    File file = await _dateFile;
    String dates = await file.readAsString();
    List<String> list = dates.split("\n");
    print(list);

    return dates;
  }

  Future<List<List<dynamic>>> get csvFileContents async {
    File file = await _csvDataFile;
    String csvString = await file.readAsString();

    List<List<dynamic>> dataList =
        const CsvToListConverter().convert(csvString, eol: "\n");

    return dataList;
  }

  Future<File> _writeNewDataToCsv(GraphCashDataObject obj) async {
    try {
      File file = await _csvDataFile;
      List<List<dynamic>> data = await csvFileContents;

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

  Future<File> _writeHeaderToCsv(GraphCashDataObject obj) async {
    try {
      File file = await _csvDataFile;

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

    _writeNewDataToCsv(v);
  }

  void createNewProject(String dayNum, String budget) {
    var v = GraphCashDataObject.header(dayNum: dayNum, budgetRemaining: budget);

    _writeHeaderToCsv(v);
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
