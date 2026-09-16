import 'package:equatable/equatable.dart';

import '../../data/entities/movie.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<Movie> movies;

  MovieLoadedState({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class MovieImportedState extends MovieState {}

class MovieErrorState extends MovieState {
  final String message;

  MovieErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
