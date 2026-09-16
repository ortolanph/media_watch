import 'package:csv/csv.dart';
import 'package:uuid/uuid.dart';

import '../../services/data_service.dart';
import '../entities/movie.dart';

class MovieRepository {
  final CSVDataService _csvDataService = FileCSVDataService();

  final List<Movie> _movies = [];

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
          entryDate: row[0] as String,
          movieName: row[1] as String,
          year: row[2] as int,
          letterboxURI: row[3],
          rating: row[4] as double,
          rewatch: parseRewatch(row[5]),
          tags: row[6] as String,
          watchedDate: row[7] as String,
        );

        _movies.add(movie);
      }
    } else {
      throw Exception("Arquivo não selecionado");
    }
  }

  bool parseRewatch(String row) {
    return (row == "Yes") ? true : false;
  }
}
