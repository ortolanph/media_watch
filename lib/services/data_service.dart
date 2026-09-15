import 'dart:convert';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

import '../data/entities/tv_show.dart';
import '../main.dart';

abstract class CSVDataService {
  Future<List<TvShow>> importData();
  Future<bool> exportData(String data);
}

class FileCSVDataService implements CSVDataService {

  @override
  Future<List<TvShow>> importData() {
    throw UnimplementedError();
  }

  @override
  Future<bool> exportData(String data) async {
    final timestamp = dateFormat.format(DateTime.now());
    final fileName = "tv_shows_$timestamp.csv";

    final blob = web.Blob([utf8.encode(data).buffer.toJS].toJS,
        web.BlobPropertyBag(type: 'text/csv;charset=utf-8;'));

    final url = web.URL.createObjectURL(blob);

    web.document.createElement('a') as web.HTMLAnchorElement
      ..href = url
      ..setAttribute('download', fileName)
      ..click();

    return true;
  }

}