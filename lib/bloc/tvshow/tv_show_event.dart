import 'package:equatable/equatable.dart';

abstract class TvShowEvent extends Equatable {
  const TvShowEvent();

  @override
  List<Object?> get props => [];
}

class TVShowLoadingEvent extends TvShowEvent {}
