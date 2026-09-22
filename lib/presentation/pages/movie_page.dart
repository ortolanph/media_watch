import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/movies/movies_bloc.dart';
import 'package:media_watch/data/entities/movie.dart';
import 'package:media_watch/data/entities/validation_result.dart';
import 'package:media_watch/presentation/views/empty_movie_view.dart';
import 'package:media_watch/presentation/views/error_view.dart';
import 'package:media_watch/presentation/views/loading_view.dart';
import 'package:media_watch/presentation/views/movie_view.dart';

import '../../bloc/movies/movies_event.dart';
import '../../bloc/movies/movies_state.dart';
import '../widgets/tags_validation_bar_widget.dart';

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
            final filtered = query.isEmpty
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
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }

  Map<TagsValidationResult, int> _emptyHistogram() {
    return {
      TagsValidationResult.emptyTags: 0,
      TagsValidationResult.invalidFormatTagsFormat: 0,
      TagsValidationResult.nonUniqueSourceTag: 0,
      TagsValidationResult.nonUniqueTmdbIdTag: 0,
      TagsValidationResult.missingGenreTag: 0,
      TagsValidationResult.validTagsField: 0,
    };
  }

  Map<TagsValidationResult, int> _buildHistogram(List<Movie> data) {
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