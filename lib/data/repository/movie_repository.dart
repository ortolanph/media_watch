import 'package:csv/csv.dart';
import 'package:uuid/uuid.dart';

import '../../services/data_service.dart';
import '../entities/movie.dart';

class MovieRepository {
  final CSVDataService _csvDataService = FileCSVDataService();

  final List<Movie> _movies = [];

  Future<List<Movie>> getMovies() async {
    return _movies;
  }

  Future<void> importData() async {
    final csvData = await _csvDataService.importData();

    if (csvData != "") {
      List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvData as String?,
      );

      rows.removeAt(0);

      _movies.clear();

      for (var row in rows) {
        Movie movie = Movie(
          id: Uuid().v4(),
          entryDate: _asString(row[0]),
          movieName: _asString(row[1]),
          year: _asInt(row[2]),
          letterboxURI: _asString(row[3]),
          rating: _asDouble(row[4]),
          rewatch: _parseRewatch(row[5]),
          tags: _asString(row[6]),
          watchedDate: _asString(row[7]),
        );

        _movies.add(movie);
      }
    } else {
      throw Exception("Arquivo não selecionado");
    }
  }

  bool _parseRewatch(dynamic row) {
    return _asString(row) == "Yes";
  }

  String _asString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  int _asInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  double _asDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
