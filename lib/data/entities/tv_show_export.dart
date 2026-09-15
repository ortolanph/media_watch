import 'package:equatable/equatable.dart';

class TvShowExport with Equatable {
  final String content;
  final String showData;

  TvShowExport({required this.content, required this.showData});

  @override
  List<Object?> get props => [content, showData];
}