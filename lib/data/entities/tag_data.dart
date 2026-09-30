import 'package:equatable/equatable.dart';

class TagData with Equatable {
  final String label;
  final Set<String> values;

  TagData({required this.label, required this.values});

  @override
  List<Object?> get props => [label, values];
}
