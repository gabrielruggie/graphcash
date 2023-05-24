import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class FileScanner<T> {
  final String filepath;
  List<List<dynamic>>? data;

  FileScanner({required this.filepath, this.data});

  void loadAsset() async {
    String assets = await rootBundle.loadString(this.filepath);

    this.data = const CsvToListConverter().convert(assets);
  }

  // Reads in data from CSV file passed in
  // List<List<dynamic>> processCsv() {
  //   return const CsvToListConverter().convert(this.assets, eol: "\n");
  // }

  // PUT WRITING STUFF BELOW
}
