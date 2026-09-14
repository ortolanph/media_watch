import 'package:bloc/bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_event.dart';
import 'package:media_watch/bloc/tvshow/tv_show_state.dart';

import '../../data/entities/tv_show.dart';
import '../../data/repository/tv_show_repository.dart';

class TVShowBloc extends Bloc<TvShowEvent, TvShowState> {
  final TVShowRepository repository;

  TVShowBloc({required this.repository}) : super(TvShowInitialState()) {
    on<TVShowLoadingEvent>(_onLoadTVShows);
  }

  Future<void> _onLoadTVShows(
      TVShowLoadingEvent event,
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

}
