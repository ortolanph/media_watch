import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieLoadingEvent extends MovieEvent {}

class MovieImportDataEvent extends MovieEvent {
  MovieImportDataEvent();

  @override
  List<Object?> get props => [];
}
