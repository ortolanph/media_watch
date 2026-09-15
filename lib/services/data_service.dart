import 'dart:convert';
import 'dart:js_interop';

import 'package:file_picker/file_picker.dart';
import 'package:web/web.dart' as web;

import '../main.dart';

abstract class CSVDataService {
  Future<String> importData();

  Future<bool> exportData(String data);
}

class FileCSVDataService implements CSVDataService {
  @override
  Future<String> importData() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return "";

    final bytes = result.files.first.bytes;
    if (bytes == null) return "";

    try {
      return utf8.decode(bytes);
    } catch (_) {
      return "";
    }
  }

  @override
  Future<bool> exportData(String data) async {
    final timestamp = dateFormat.format(DateTime.now());
    final fileName = "tv_shows_$timestamp.csv";

    final blob = web.Blob(
      [utf8.encode(data).buffer.toJS].toJS,
      web.BlobPropertyBag(type: 'text/csv;charset=utf-8;'),
    );

    final url = web.URL.createObjectURL(blob);

    web.document.createElement('a') as web.HTMLAnchorElement
      ..href = url
      ..setAttribute('download', fileName)
      ..click();

    return true;
  }
}
