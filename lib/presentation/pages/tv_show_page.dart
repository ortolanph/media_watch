import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_event.dart';
import 'package:media_watch/bloc/tvshow/tv_show_state.dart';
import 'package:media_watch/presentation/views/loading_view.dart';
import 'package:media_watch/presentation/views/tv_show_view.dart';
import 'package:media_watch/presentation/widgets/record_counter.dart';

import '../../data/entities/tv_show.dart';
import '../views/empty_tv_show_view.dart';
import '../views/error_view.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({super.key});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late List<TvShow> filtered = [];

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
      body: BlocConsumer<TvShowBloc, TvShowState>(
        listener: (context, state) {
          if (state is TvShowCopiedToClipboardState) {
            Clipboard.setData(ClipboardData(text: state.content));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Conteúdo de ${state
                      .showData} copiado para a área de transferência!",
                ),
              ),
            );
            context.read<TvShowBloc>().add(TvShowLoadingEvent());
          }

          if (state is TvShowExportedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Dados exportados com sucesso!")),
            );
            context.read<TvShowBloc>().add(TvShowLoadingEvent());
          }

          if (state is TvShowImportedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Dados importados com sucesso!")),
            );
            context.read<TvShowBloc>().add(TvShowLoadingEvent());
          }
        },
        builder: (context, state) {
          Widget content;


          if (state is TvShowLoadingState || state is TvShowImportedState) {
            content = LoadingView();
          }  else  if (state is TvShowLoadedState) {
            final query = _searchQuery.toLowerCase();
            filtered = query.isEmpty
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

            content = (filtered.isEmpty)
                ? EmptyTvShowView()
                : TvShowView(tvShows: filtered);
          } else if (state is TvShowErrorState) {
            content = ErrorView(error: state.message);
          } else {
            content = Placeholder();
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
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
}
