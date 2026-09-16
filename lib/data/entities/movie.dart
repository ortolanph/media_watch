import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie with Equatable {
  final String id;
  final String entryDate;
  final String movieName;
  final int year;
  final String letterboxURI;
  final double rating;
  final bool rewatch;
  final String tags;
  final String watchedDate;

  Movie({
    required this.id,
    required this.entryDate,
    required this.movieName,
    required this.year,
    required this.letterboxURI,
    required this.rating,
    required this.rewatch,
    required this.tags,
    required this.watchedDate,
  });

  @override
  List<Object?> get props => [
    id,
    entryDate,
    movieName,
    year,
    letterboxURI,
    rating,
    rating,
    rewatch,
    tags,
    watchedDate,
  ];
}
