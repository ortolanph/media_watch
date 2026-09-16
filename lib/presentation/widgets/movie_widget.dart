import 'package:flutter/material.dart';

import '../../data/entities/movie.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              title: Text(
                movie.movieName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      )
    );
  }
}
