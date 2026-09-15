import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../bloc/tvshow/tv_show_event.dart';
import '../../data/entities/tv_show.dart';

class TvShowWidget extends StatelessWidget {
  const TvShowWidget({super.key, required this.tvShow});

  final TvShow tvShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              title: _formatTvShowName(
                tvShow.show,
                tvShow.season,
                tvShow.tmdbId,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    _formatWatchedYear(tvShow.yearWatched),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(tvShow.source),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(tvShow.kind.name.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await Navigator.pushNamed(
                        context,
                        "/shows/edit",
                        arguments: tvShow,
                      );
                      if (context.mounted) {
                        context.read<TvShowBloc>().add(TvShowLoadingEvent());
                      }
                    },
                    icon: Icon(Icons.edit),
                    tooltip: "Editar TVShow",
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<TvShowBloc>().add(
                        TvShowCopyToClipboardEvent(id: tvShow.id),
                      );
                    },
                    icon: Icon(Icons.copy),
                    tooltip: "Exportar para CSV",
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<TvShowBloc>().add(
                        TvShowDeleteEvent(id: tvShow.id),
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                    tooltip: "Apagar TVShow",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formatTvShowName(String show, int season, int tmdbId) {
    return new RichText(
      text: TextSpan(
        text: "$show - S${season.toString().padLeft(2, '0')}",
        style: new TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        recognizer: new TapGestureRecognizer()
          ..onTap = () {
            launchUrlString("https://www.themoviedb.org/tv/$tmdbId");
          },
      ),
    );
  }

  Widget _formatWatchedYear(int yearWatched) {
    return Row(
      children: [
        Icon(Icons.remove_red_eye_sharp),
        SizedBox(width: 4),
        Text(yearWatched.toString()),
      ],
    );
  }
}
