import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_watch/bloc/movies/movie_state.dart';
import 'package:media_watch/bloc/tags/tag_bloc.dart';
import 'package:media_watch/bloc/tags/tag_state.dart';
import 'package:media_watch/presentation/views/loading_view.dart';

import '../views/tag_view.dart';

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tags')),
      body: BlocConsumer<TagBloc, TagState>(
        listener: (context, state) {},
        builder: (context, state) {
          Widget content;

          if (state is MovieLoadingState) {
            content = LoadingView();
          } else if (state is TagLoadedState) {
            content = TagView(data: state.tagData);
          } else {
            return Placeholder();
          }

          return Column(children: [Expanded(child: content)]);
        },
      ),
    );
  }
}
