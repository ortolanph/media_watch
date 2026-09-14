import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/tvshow/tv_show_bloc.dart';
import 'package:media_watch/data/entities/tv_show_kind.dart';
import 'package:uuid/uuid.dart';

import '../../bloc/tvshow/tv_show_event.dart';
import '../../bloc/tvshow/tv_show_state.dart';
import '../../data/entities/tv_show.dart';
import '../views/tv_show_edit_view.dart';

class TvShowEditPage extends StatefulWidget {
  const TvShowEditPage({super.key});

  @override
  State<TvShowEditPage> createState() => _TvShowEditPageState();
}

class _TvShowEditPageState extends State<TvShowEditPage> {
  final _showController = TextEditingController();
  final _seasonController = TextEditingController();
  final _yearWatchedController = TextEditingController();
  final _sourceController = TextEditingController();
  final _tmdbIdController = TextEditingController();
  late String selected = TvShowKind.values.first.name;

  TvShow? _editing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_editing == null) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg is TvShow) {
        _editing = arg;
        _showController.text = arg.show;
        _seasonController.text = arg.season.toString();
        _yearWatchedController.text = arg.yearWatched.toString();
        _sourceController.text = arg.source;
        _tmdbIdController.text = arg.tmdbId.toString();
        selected = arg.kind.name;
      }
    }
  }

  @override
  void dispose() {
    _showController.dispose();
    _seasonController.dispose();
    _yearWatchedController.dispose();
    _sourceController.dispose();
    _tmdbIdController.dispose();
    super.dispose();
  }

  void _save(BuildContext context) {
    final season = int.tryParse(_seasonController.text);
    final yearWatched = int.tryParse(_yearWatchedController.text);
    final tmdbId = int.tryParse(_tmdbIdController.text);

    if (_showController.text.isEmpty ||
        season == null ||
        yearWatched == null ||
        _sourceController.text.isEmpty ||
        tmdbId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos corretamente.")),
      );
      return;
    }

    final tvShow = TvShow(
      id: _editing?.id ?? Uuid().v4(),
      show: _showController.text,
      season: season,
      yearWatched: yearWatched,
      source: _sourceController.text,
      tmdbId: tmdbId,
      kind: TvShowKind.values.firstWhere((e) => e.name == selected),
    );

    if (_editing != null) {
      context.read<TvShowBloc>().add(
        TvShowUpdatingEvent(tvShowId: _editing!.id, data: tvShow),
      );
    } else {
      context.read<TvShowBloc>().add(TvShowSavingEvent(data: tvShow));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editing != null ? 'Editar TV Show' : 'Novo TV Show'),
        actions: [
          IconButton(
            onPressed: () => _save(context),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: BlocListener<TvShowBloc, TvShowState>(
        listener: (context, state) {
          if (state is TvShowSavedState || state is TvShowUpdatedState) {
            Navigator.pop(context);
          }

          if (state is TvShowErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: TvShowEditView(
          showController: _showController,
          seasonController: _seasonController,
          yearWatchedController: _yearWatchedController,
          sourceController: _sourceController,
          tmdbIdController: _tmdbIdController,
          selectedKind: selected,
        ),
      ),
    );
  }
}
