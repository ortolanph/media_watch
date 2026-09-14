import 'package:bloc/bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_event.dart';
import 'package:media_watch/bloc/tvshow/tv_show_state.dart';

import '../../data/entities/tv_show.dart';
import '../../data/repository/tv_show_repository.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  final TVShowRepository repository;

  TvShowBloc({required this.repository}) : super(TvShowInitialState()) {
    on<TvShowLoadingEvent>(_onLoadTVShows);
    on<TvShowUpdatingEvent>(_onUpdateTVShow);
    on<TvShowSavingEvent>(_onSaveTVShow);
  }

  Future<void> _onLoadTVShows(
    TvShowLoadingEvent event,
    Emitter<TvShowState> emit,
  ) async {
    emit(TvShowLoadingState());

    try {
      List<TvShow> tvShows = await repository.loadTvShows();

      emit(TvShowLoadedState(tvShows: tvShows));
    } catch (error) {
      emit(TvShowErrorState(message: error.toString()));
    }
  }

  Future<void> _onUpdateTVShow(
    TvShowUpdatingEvent event,
    Emitter<TvShowState> emit,
  ) async {
    try {
      await repository.updateTvShow(event.tvShowId, event.data);
      emit(TvShowUpdatedState());
    } catch (error) {
      emit(TvShowErrorState(message: error.toString()));
    }
  }

  Future<void> _onSaveTVShow(
    TvShowSavingEvent event,
    Emitter<TvShowState> emit,
  ) async {
    try {
      await repository.saveTvShow(event.data);
      emit(TvShowSavedState());
    } catch (error) {
      emit(TvShowErrorState(message: error.toString()));
    }
  }
}
