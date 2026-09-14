import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_event.dart';
import 'package:media_watch/bloc/tvshow/tv_show_state.dart';
import 'package:media_watch/presentation/views/loading_view.dart';
import 'package:media_watch/presentation/views/tv_show_view.dart';

import '../views/error_view.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({super.key});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Show'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, "/shows/edit");
              if (context.mounted) {
                context.read<TvShowBloc>().add(TvShowLoadingEvent());
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<TvShowBloc, TvShowState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TvShowLoadingState) {
                  return LoadingView();
                }

                if (state is TvShowLoadedState) {
                  return TvShowView(tvShows: state.tvShows);
                }

                if (state is TvShowErrorState) {
                  return ErrorView(error: state.message);
                }

                return const Placeholder();
              },
            ),
          ),
        ],
      ),
    );
  }
}
