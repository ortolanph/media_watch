import 'package:equatable/equatable.dart';

import '../../data/entities/tv_show.dart';

abstract class TvShowEvent extends Equatable {
  const TvShowEvent();

  @override
  List<Object?> get props => [];
}

class TvShowLoadingEvent extends TvShowEvent {}

class TvShowUpdatingEvent extends TvShowEvent {
  final String tvShowId;
  final TvShow data;

  const TvShowUpdatingEvent({required this.tvShowId, required this.data});

  @override
  List<Object?> get props => [tvShowId, data];
}

class TvShowSavingEvent extends TvShowEvent {
  final TvShow data;

  const TvShowSavingEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class TvShowDeleteEvent extends TvShowEvent {
  final String id;

  const TvShowDeleteEvent({required this.id});
}

class TvShowCopyToClipboardEvent extends TvShowEvent {
  final String id;

  const TvShowCopyToClipboardEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class TvShowExportDataEvent extends TvShowEvent {
  const TvShowExportDataEvent();
}

class TvShowImportDataEvent extends TvShowEvent {
  const TvShowImportDataEvent();
}
