import 'package:equatable/equatable.dart';

import '../../data/entities/tag_data.dart';

abstract class TagState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TagInitialState extends TagState {}

class TagLoadingState extends TagState {}

class TagLoadedState extends TagState {
  final List<TagData> tagData;

  TagLoadedState({required this.tagData});

  @override
  List<Object?> get props => [tagData];
}

class TagErrorState extends TagState {
  final String message;

  TagErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
