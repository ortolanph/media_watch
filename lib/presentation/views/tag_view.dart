import 'package:flutter/cupertino.dart';
import 'package:media_watch/data/entities/tag_data.dart';

import '../widgets/tag_widget.dart';

class TagView extends StatefulWidget {
  const TagView({super.key, required this.data});

  final List<TagData> data;

  @override
  State<TagView> createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (context, index) => TagWidget(tagData: widget.data[index]),
    );
  }
}
