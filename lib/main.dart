import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:media_watch/bloc/movies/movies_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_bloc.dart';
import 'package:media_watch/data/repository/movie_repository.dart';
import 'package:media_watch/presentation/pages/home_page.dart';
import 'package:media_watch/presentation/pages/movie_page.dart';
import 'package:media_watch/presentation/pages/tv_show_edit_page.dart';
import 'package:media_watch/presentation/pages/tv_show_page.dart';

import 'bloc/movies/movies_event.dart';
import 'bloc/tvshow/tv_show_event.dart';
import 'data/repository/tv_show_repository.dart';

final DateFormat dateFormat = DateFormat("yyyyddMM_HHmmss");

void main() {
  TVShowRepository tvShowRepository = TVShowRepository();
  TvShowBloc tvShowBloc = TvShowBloc(repository: tvShowRepository);
  MovieRepository movieRepository = MovieRepository();

  runApp(
    MaterialApp(
      title: "Media Watch",
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
        "/shows": (context) => BlocProvider.value(
          value: tvShowBloc..add(TvShowLoadingEvent()),
          child: TvShowPage(),
        ),
        "/shows/edit": (context) => BlocProvider.value(
          value: tvShowBloc..add(TvShowLoadingEvent()),
          child: TvShowEditPage(),
        ),
        "/movies": (context) => BlocProvider(
          create: (context) =>
              MovieBloc(repository: movieRepository)..add(MovieLoadingEvent()),
          child: MoviesPage(),
        ),
      },
    ),
  );
}
