import 'package:flutter/material.dart';
import 'package:media_watch/presentation/widgets/tv_show_widget.dart';

import '../../data/entities/tv_show.dart';

class TvShowView extends StatefulWidget {
  const TvShowView({super.key, required this.tvShows});

  final List<TvShow> tvShows;

  @override
  State<TvShowView> createState() => _TvShowViewState();
}

class _TvShowViewState extends State<TvShowView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tvShows.length,
      itemBuilder: (context, index) =>
          TvShowWidget(tvShow: widget.tvShows[index]),
    );
  }
}
