import 'package:bloc/bloc.dart';
import 'package:media_watch/bloc/movies/movie_event.dart';
import 'package:media_watch/data/repository/movie_repository.dart';

import '../../data/entities/movie.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _repository;

  MovieBloc({required MovieRepository repository})
    : _repository = repository,
      super(MovieInitialState()) {
    on<MovieLoadingEvent>(_onLoadMovies);
    on<MovieImportDataEvent>(_onImportData);
  }

  Future<void> _onLoadMovies(
    MovieLoadingEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoadingState());
    List<Movie> movies = await _repository.getMovies();
    emit(MovieLoadedState(movies: movies));
  }

  Future<void> _onImportData(
    MovieImportDataEvent event,
    Emitter<MovieState> emit,
  ) async {
    try {
      await _repository.importData();
      emit(MovieImportedState());
    } catch (e) {
      emit(MovieErrorState(message: e.toString()));
    }
  }
}
