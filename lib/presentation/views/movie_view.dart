import 'package:flutter/material.dart';
import 'package:media_watch/presentation/widgets/movie_widget.dart';

import '../../data/entities/movie.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key, required this.movies});

  final List<Movie> movies;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.movies.length,
      itemBuilder: (context, index) => MovieWidget(movie: widget.movies[index]),
    );
  }
}
