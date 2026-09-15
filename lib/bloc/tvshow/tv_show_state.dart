import 'package:equatable/equatable.dart';

import '../../data/entities/tv_show.dart';

abstract class TvShowState extends Equatable {
  const TvShowState();

  @override
  List<Object?> get props => [];
}

class TvShowInitialState extends TvShowState {}

class TvShowLoadingState extends TvShowState {}

class TvShowLoadedState extends TvShowState {
  final List<TvShow> tvShows;

  const TvShowLoadedState({required this.tvShows});

  @override
  List<Object?> get props => [tvShows];
}

class TvShowErrorState extends TvShowState {
  final String message;

  const TvShowErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TvShowUpdatedState extends TvShowState {}

class TvShowSavedState extends TvShowState {}

class TvShowCopiedToClipboardState extends TvShowState {
  final String content;
  final String showData;

  const TvShowCopiedToClipboardState({
    required this.content,
    required this.showData,
  });

  @override
  List<Object?> get props => [content, showData];
}
