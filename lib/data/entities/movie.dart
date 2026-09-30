import 'package:equatable/equatable.dart';
import 'package:media_watch/data/entities/validation_result.dart';

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
  final TagValidationResult validationResult;

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
    required this.validationResult,
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
    validationResult,
  ];
}
