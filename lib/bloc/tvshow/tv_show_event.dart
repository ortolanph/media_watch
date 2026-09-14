import 'package:equatable/equatable.dart';

import '../../data/entities/tv_show.dart';

abstract class TvShowEvent extends Equatable {
  const TvShowEvent();

  @override
  List<Object?> get props => [];
}

class TVShowLoadingEvent extends TvShowEvent {}

class TvShowUpdatingEvent extends TvShowEvent {
  final String tvShowId;
  final TvShow data;

  const TvShowUpdatingEvent({required this.tvShowId, required this.data});
}

class TvShowSavingEvent extends TvShowEvent {
  final TvShow data;

  const TvShowSavingEvent({required this.data});
}
