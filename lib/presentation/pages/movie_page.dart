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
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Buscar Filme",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: BlocConsumer<MovieBloc, MovieState>(
              listener: (context, state) {
                if (state is MovieImportedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Dados importados com sucesso!")),
                  );
                  context.read<MovieBloc>().add(MovieLoadingEvent());
                }
              },
              builder: (context, state) {
                if (state is MovieLoadingState || state is MovieImportedState) {
                  return LoadingView();
                }

                if (state is MovieLoadedState) {
                  final query = _searchQuery.toLowerCase();
                  final filtered = query.isEmpty
                      ? state.movies
                      : state.movies
                            .where(
                              (r) =>
                                  r.movieName.toLowerCase().contains(query) ||
                                  r.entryDate.toLowerCase().contains(query),
                            )
                            .toList();

                  return filtered.isEmpty
                      ? EmptyMovieView()
                      : MovieView(movies: filtered);
                }

                if (state is MovieErrorState) {
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
