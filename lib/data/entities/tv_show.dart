import 'package:equatable/equatable.dart';
import 'package:media_watch/data/entities/tv_show_kind.dart';

class TvShow with Equatable {
  final String id;
  final String show;
  final int season;
  final int yearWatched;
  final String source;
  final int tmdbId;
  final TvShowKind kind;

  TvShow({
    required this.id,
    required this.show,
    required this.season,
    required this.yearWatched,
    required this.source,
    required this.tmdbId,
    required this.kind,
  });

  @override
  List<Object?> get props => [
    id,
    show,
    season,
    yearWatched,
    source,
    tmdbId,
    kind,
  ];
}
