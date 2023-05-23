import 'dart:io';
import 'package:csv/csv.dart';

class FileScanner<T> {
  final File file;

  FileScanner({required this.file});

  // Reads in data from CSV file passed in
  List<List<dynamic>> processCsv() {
    this.file.readAsString().then((String result) {
      return const CsvToListConverter().convert(result, eol: "\n");
    });

    throw const FormatException('There was a problem processing file');
  }

  // List<T> getListOfObjects() {
  //   List<List<dynamic>> csvData = processCsv();
  //   List<T> objects = <T>[];

  //   // Start at 1 to ignore header content
  //   for (var i = 1; i < csvData.length; i++) {
  //     csvData[i][4];
  //   }
  // }

  // PUT WRITING STUFF BELOW
}
