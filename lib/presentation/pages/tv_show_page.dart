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
        title: const Text('TV Show'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, "/shows/edit");
              if (context.mounted) {
                context.read<TvShowBloc>().add(TvShowLoadingEvent());
              }
            },
            tooltip: "Adicionar TV Show",
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              if (context.mounted) {
                context.read<TvShowBloc>().add(TvShowExportDataEvent());
              }
            },
            tooltip: "Exportar data",
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: () async {
              if (context.mounted) {
                context.read<TvShowBloc>().add(TvShowImportDataEvent());
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
                labelText: "Buscar TV Show",
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
            child: BlocConsumer<TvShowBloc, TvShowState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is TvShowLoadingState) {
                  return LoadingView();
                }

                if (state is TvShowLoadedState) {
                  final query = _searchQuery.toLowerCase();
                  final filtered = query.isEmpty
                      ? state.tvShows
                      : state.tvShows
                            .where(
                              (r) =>
                                  r.show.toLowerCase().contains(query) ||
                                  r.source.toLowerCase().contains(query) ||
                                  r.yearWatched.toString().contains(query) ||
                                  r.kind.name.toLowerCase().contains(query),
                            )
                            .toList();
                  return TvShowView(tvShows: filtered);
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
