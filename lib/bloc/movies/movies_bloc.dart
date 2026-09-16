import 'package:bloc/bloc.dart';
import 'package:media_watch/bloc/movies/movies_event.dart';
import 'package:media_watch/data/repository/movie_repository.dart';

import 'movies_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc({required this.repository}) : super(MovieInitialState()) {
    on<MovieLoadingEvent>(_onLoadMovies);
    on<MovieImportDataEvent>(_onImportData);
  }

  Future<void> _onLoadMovies(
    MovieLoadingEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoadingState());
    emit(MovieLoadedState(movies: []));
  }

  Future<void> _onImportData(
    MovieImportDataEvent event,
    Emitter<MovieState> emit,
  ) async {
    try {
      await repository.importData();
      emit(MovieImportedState());
    } catch (e) {
      emit(MovieErrorState(message: e.toString()));
    }
  }
}
