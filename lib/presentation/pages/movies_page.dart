import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/movies/movies_bloc.dart';
import 'package:media_watch/presentation/views/empty_movie_view.dart';
import 'package:media_watch/presentation/views/error_view.dart';
import 'package:media_watch/presentation/views/loading_view.dart';
import 'package:media_watch/presentation/views/movie_view.dart';

import '../../bloc/movies/movies_event.dart';
import '../../bloc/movies/movies_state.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () async {
              if (context.mounted) {
                context.read<MovieBloc>().add(MovieImportDataEvent());
              }
            },
            tooltip: "Importar arquivo",
            icon: Icon(Icons.upload),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MovieBloc, MovieState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is MovieLoadingState) {
                  return LoadingView();
                }

                if(state is MovieLoadedState) {
                  if (state.movies.isEmpty) {
                    return EmptyMovieView();
                  } else {
                    return MovieView();
                  }
                }

                if(state is MovieErrorState) {
                  return ErrorView(error: state.message);
                }

                return Placeholder();
              },
            ),
          ),
        ],
      ),
    );
  }
}
