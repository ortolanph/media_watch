import 'package:csv/csv.dart';
import 'package:media_watch/data/entities/tv_show_export.dart';
import 'package:media_watch/data/entities/tv_show_kind.dart';
import 'package:media_watch/services/data_service.dart';
import 'package:uuid/uuid.dart';

import '../entities/tv_show.dart';

class TVShowRepository {
  final CSVDataService _csvDataService = FileCSVDataService();

  final List<TvShow> _tvShows = [];

  Future<List<TvShow>> loadTvShows() async {
    return _tvShows;
  }

  Future<void> updateTvShow(String tvShowId, TvShow data) async {
    TvShow tvShow = _tvShows.where((tvShow) => tvShow.id == tvShowId).first;

    TvShow updated = TvShow(
      id: tvShow.id,
      show: data.show,
      season: data.season,
      yearWatched: data.yearWatched,
      source: data.source,
      tmdbId: data.tmdbId,
      kind: data.kind,
    );

    _tvShows.remove(tvShow);
    _tvShows.add(updated);
  }

  Future<void> saveTvShow(TvShow data) async {
    _tvShows.add(data);
  }

  Future<void> deleteTVShow(String id) async {
    _tvShows.retainWhere((s) => s.id != id);
  }

  Future<TvShowExport> generateContentToClipboard(String id) async {
    TvShow tvShow = _tvShows.where((s) => s.id == id).first;

    final data = [
      [
        tvShow.show,
        tvShow.season,
        tvShow.yearWatched,
        tvShow.source,
        tvShow.tmdbId,
        tvShow.kind.name,
      ],
    ];

    ListToCsvConverter csv = ListToCsvConverter();

    final showData =
        "${tvShow.show} - S${tvShow.season.toString().padLeft(2, '0')}";

    return TvShowExport(content: csv.convert(data), showData: showData);
  }

  Future<void> exportData() async {
    List<List<Object>> data = _tvShows
        .map(
          (tvShow) => [
            tvShow.show,
            tvShow.season,
            tvShow.yearWatched,
            tvShow.source,
            tvShow.tmdbId,
            tvShow.kind.name,
          ],
        )
        .toList();

    data.insert(0, [
      "show",
      "season",
      "yearWatched",
      "source",
      "tmdb_id",
      "kind",
    ]);

    ListToCsvConverter csv = ListToCsvConverter();

    await _csvDataService.exportData(csv.convert(data));
  }

  Future<void> importData() async {
    final csvData = await _csvDataService.importData();

    if (csvData != "") {
      List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvData as String?,
      );

      rows.removeAt(0);

      _tvShows.clear();

      for (var row in rows) {
        TvShow tvShow = TvShow(
          id: Uuid().v4(),
          show: row[0] as String,
          season: row[1] as int,
          yearWatched: row[2] as int,
          source: row[3] as String,
          tmdbId: row[4] as int,
          kind: TvShowKind.values.firstWhere(
            (k) => k.name == (row[5] as String),
            orElse: () => TvShowKind.regular,
          ),
        );

        _tvShows.add(tvShow);
      }
    } else {
      throw Exception("Arquivo não selecionado");
    }
  }
}
