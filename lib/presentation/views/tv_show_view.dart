import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_bloc.dart';
import 'package:media_watch/presentation/widgets/tv_show_widget.dart';

import '../../bloc/tvshow/tv_show_event.dart';
import '../../bloc/tvshow/tv_show_state.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        BlocListener<TvShowBloc, TvShowState>(
          listener: (context, state) {
            if (state is TvShowCopiedToClipboardState) {
              Clipboard.setData(ClipboardData(text: state.content));

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Conteúdo de ${state.showData} copiado para a área de transferência!",
                  ),
                ),
              );

              context.read<TvShowBloc>().add(TvShowLoadingEvent());
            }

            if (state is TvShowExportedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Dados exportados com sucesso!")),
              );

              context.read<TvShowBloc>().add(TvShowLoadingEvent());
            }

            if (state is TvShowImportedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Dados importados com sucesso!")),
              );

              context.read<TvShowBloc>().add(TvShowLoadingEvent());
            }
          },
          bloc: context.read<TvShowBloc>(),
          child: Container(),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.tvShows.length,
            itemBuilder: (context, index) =>
                TvShowWidget(tvShow: widget.tvShows[index]),
          ),
        ),
      ],
    );
  }
}
