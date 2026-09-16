import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/movies/movies_bloc.dart';
import 'package:media_watch/bloc/movies/movies_event.dart';

import '../../bloc/movies/movies_state.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieImportedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Dados importados com sucesso!")),
              );

              context.read<MovieBloc>().add(MovieLoadingEvent());
            }
          },
          bloc: context.read<MovieBloc>(),
          child: Container(),
        ),
        //Expanded(child: )
      ],
    );
  }
}
