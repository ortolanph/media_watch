import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_bloc.dart';
import 'package:media_watch/presentation/pages/home_page.dart';
import 'package:media_watch/presentation/pages/tv_show_page.dart';

import 'bloc/tvshow/tv_show_event.dart';
import 'data/repository/tv_show_repository.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Media Watch",
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
        "/shows": (context) => BlocProvider(
          create: (context) =>
              TVShowBloc(repository: TVShowRepository())
                ..add(TVShowLoadingEvent()),
          child: TvShowPage(),
        ),
      },
    ),
  );
}
