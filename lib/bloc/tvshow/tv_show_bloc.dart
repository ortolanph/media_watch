import 'package:bloc/bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_event.dart';
import 'package:media_watch/bloc/tvshow/tv_show_state.dart';
import 'package:media_watch/data/entities/tv_show_export.dart';

import '../../data/entities/tv_show.dart';
import '../../data/repository/tv_show_repository.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  final TVShowRepository repository;

  TvShowBloc({required this.repository}) : super(TvShowInitialState()) {
    on<TvShowLoadingEvent>(_onLoadTvShows);
    on<TvShowUpdatingEvent>(_onUpdateTvShow);
    on<TvShowSavingEvent>(_onSaveTvShow);
    on<TvShowDeleteEvent>(_onDeleteTvShow);
    on<TvShowCopyToClipboardEvent>(_onCopyToClipboardTvShow);
    on<TvShowExportDataEvent>(_onExportDataTvShow);
  }

  Future<void> _onLoadTvShows(
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

  Future<void> _onUpdateTvShow(
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

  Future<void> _onSaveTvShow(
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

  Future<void> _onDeleteTvShow(
    TvShowDeleteEvent event,
    Emitter<TvShowState> emit,
  ) async {
    try {
      emit(TvShowLoadingState());
      await repository.deleteTVShow(event.id);
      List<TvShow> tvShows = await repository.loadTvShows();
      emit(TvShowLoadedState(tvShows: tvShows));
    } catch (error) {
      emit(TvShowErrorState(message: error.toString()));
    }
  }

  Future<void> _onCopyToClipboardTvShow(
    TvShowCopyToClipboardEvent event,
    Emitter<TvShowState> emit,
  ) async {
    try {
      TvShowExport export = await repository.generateContentToClipboard(
        event.id,
      );
      emit(
        TvShowCopiedToClipboardState(
          content: export.content,
          showData: export.showData,
        ),
      );
    } catch (error) {
      emit(TvShowErrorState(message: error.toString()));
    }
  }

  Future<void> _onExportDataTvShow(
    TvShowExportDataEvent event,
    Emitter<TvShowState> emit,
  ) async {
    try {
      await repository.exportData();
      emit(TvShowExportedState());
    } catch(error) {
      emit(TvShowErrorState(message: error.toString()));
    }
  }
}
