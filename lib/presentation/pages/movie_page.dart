import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/movies/movie_bloc.dart';
import 'package:media_watch/data/entities/movie.dart';
import 'package:media_watch/data/entities/validation_result.dart';
import 'package:media_watch/presentation/views/empty_movie_view.dart';
import 'package:media_watch/presentation/views/error_view.dart';
import 'package:media_watch/presentation/views/loading_view.dart';
import 'package:media_watch/presentation/views/movie_view.dart';
import 'package:media_watch/presentation/widgets/record_counter.dart';
import 'package:media_watch/presentation/widgets/toggled_tags_validation_bar_widget.dart';

import '../../bloc/movies/movie_event.dart';
import '../../bloc/movies/movie_state.dart';
import '../widgets/tags_validation_bar_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late List<Movie> filtered = [];

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
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, "/tags");
              if (context.mounted) {
                context.read<MovieBloc>().add(MovieLoadingEvent());
              }
            },
            tooltip: "Visualizar Tags",
            icon: Icon(Icons.label),
          ),
        ],
      ),
      body: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is MovieImportedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Dados importados com sucesso!")),
            );
            context.read<MovieBloc>().add(MovieLoadingEvent());
          }
        },
        builder: (context, state) {
          var histogram = _emptyHistogram();
          Widget content;

          if (state is MovieLoadingState || state is MovieImportedState) {
            content = LoadingView();
          } else if (state is MovieLoadedState) {
            final query = _searchQuery.toLowerCase();
            filtered = query.isEmpty
                ? state.movies
                : state.movies
                      .where(
                        (r) =>
                            r.movieName.toLowerCase().contains(query) ||
                            r.entryDate.toLowerCase().contains(query) ||
                            r.tags.toLowerCase().contains(query),
                      )
                      .toList();

            histogram = _buildHistogram(filtered);
            content = filtered.isEmpty
                ? EmptyMovieView()
                : MovieView(movies: filtered);
          } else if (state is MovieErrorState) {
            content = ErrorView(error: state.message);
          } else {
            content = Placeholder();
          }

          return Column(
            children: [
              TagsValidationBarWidget(histogram: histogram),
              ToggledTagsValidationBarWidget(histogram: histogram),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
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
                        onChanged: (value) =>
                            setState(() => _searchQuery = value),
                      ),
                    ),
                    RecordCounter(recordCount: filtered.length),
                  ],
                ),
              ),
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }

  Map<TagValidationResult, int> _emptyHistogram() {
    return {
      TagValidationResult.emptyTags: 0,
      TagValidationResult.invalidTagsFormat: 0,
      TagValidationResult.missingSourceTag: 0,
      TagValidationResult.nonUniqueSourceTag: 0,
      TagValidationResult.missingTMDBIDTag: 0,
      TagValidationResult.nonUniqueTmdbIdTag: 0,
      TagValidationResult.missingGenreTag: 0,
      TagValidationResult.validTagsField: 0,
    };
  }

  Map<TagValidationResult, int> _buildHistogram(List<Movie> data) {
    final histogram = _emptyHistogram();
    for (var movie in data) {
      histogram.update(
        movie.validationResult,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }
    return histogram;
  }
}
