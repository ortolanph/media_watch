import 'package:equatable/equatable.dart';

abstract class TagEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TagLoadingEvent extends TagEvent {}
