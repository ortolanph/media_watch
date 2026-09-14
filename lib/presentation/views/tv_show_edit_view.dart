import 'package:flutter/material.dart';

import '../../data/entities/tv_show_kind.dart';

class TvShowEditView extends StatelessWidget {
  TvShowEditView({
    super.key,
    required this.showController,
    required this.seasonController,
    required this.yearWatchedController,
    required this.sourceController,
    required this.tmdbIdController,
    required this.selectedKind,
  });

  final TextEditingController showController;
  final TextEditingController seasonController;
  final TextEditingController yearWatchedController;
  final TextEditingController sourceController;
  final TextEditingController tmdbIdController;
  final String selectedKind;

  final List<String> _kinds = TvShowKind.values.map((e) => e.name).toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: TextField(
              controller: showController,
              decoration: InputDecoration(hintText: "Show"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: TextField(
              controller: seasonController,
              decoration: InputDecoration(hintText: "Season"),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: TextField(
              controller: yearWatchedController,
              decoration: InputDecoration(hintText: "Year Watched"),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: TextField(
              controller: sourceController,
              decoration: InputDecoration(hintText: "Source"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: TextField(
              controller: tmdbIdController,
              decoration: InputDecoration(hintText: "TMDB ID"),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
            child: DropdownButtonFormField(
              initialValue: selectedKind,
              items: _kinds.map((kind) {
                return DropdownMenuItem(value: kind, child: Text(kind));
              }).toList(),
              onChanged: (value) {
                // Handle kind change
              },
              decoration: InputDecoration(hintText: "Kind"),
            ),
          ),
        ],
      ),
    );
  }
}
