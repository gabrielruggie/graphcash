import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
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

  Future<List<List<dynamic>>> get FileContents async {
    File file = await localFile;
    String csvString = await file.readAsString();

    List<List<dynamic>> dataList =
        const CsvToListConverter().convert(csvString, eol: "\n");

    print(dataList);
    return dataList;
  }

  void writeToFile(GraphCashDataObject obj) async {
    try {
      List<List<dynamic>> data = await FileContents;

      List<dynamic> newRow = <dynamic>[];
      newRow.add(obj.transactionName);
      newRow.add(obj.dayNum);
      newRow.add(obj.transactionAmt);
      newRow.add(obj.categoryName);
      newRow.add(obj.budgetRemaining);

      data.add(newRow);
    } catch (e) {
      throw new FormatException("There was an error writing to file");
    }
  }
}

class GraphCashDataObject {
  final String transactionName;
  final int dayNum;
  final int transactionAmt;
  final String categoryName;
  final String budgetRemaining;

  GraphCashDataObject(
      {required this.transactionName,
      required this.dayNum,
      required this.transactionAmt,
      required this.categoryName,
      required this.budgetRemaining});
}
