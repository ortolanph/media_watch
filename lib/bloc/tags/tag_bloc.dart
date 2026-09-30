import 'package:bloc/bloc.dart';
import 'package:media_watch/bloc/tags/tag_event.dart';
import 'package:media_watch/bloc/tags/tag_state.dart';
import 'package:media_watch/data/repository/movie_repository.dart';

import '../../data/entities/movie.dart';
import '../../data/entities/tag_data.dart';
import '../../data/entities/validation_result.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final MovieRepository _repository;
  final String _tagSeparator = ",";
  final String _keyValueSeparator = ":";
  final String _tmdbId = "tmdb_id";

  TagBloc({required MovieRepository repository})
    : _repository = repository,
      super(TagInitialState()) {
    on<TagLoadingEvent>(_onLoadStatistics);
  }

  Future<void> _onLoadStatistics(
    TagLoadingEvent event,
    Emitter<TagState> emit,
  ) async {
    emit(TagLoadingState());
    List<Movie> movies = await _repository.getMovies();

    if (movies.isEmpty) {
      emit(TagErrorState(message: "Movies are not loaded"));
    }

    Map<String, Set<String>> parsedTagData = _loadTagData(movies);
    List<TagData> tagData = [];

    for (var parsedData in parsedTagData.entries) {
      tagData.add(TagData(label: parsedData.key, values: parsedData.value));
    }

    emit(TagLoadedState(tagData: tagData));
  }

  Map<String, Set<String>> _loadTagData(List<Movie> movies) {
    Map<String, Set<String>> tagData = {};

    List<String> validTags = movies
        .where(
          (movie) =>
              TagValidationResult.validTagsField == movie.validationResult,
        )
        .map((movie) => movie.tags)
        .toList();

    for (final entry in validTags) {
      for (final tag in entry.split(_tagSeparator)) {
        List<String> tagMap = tag.trim().split(_keyValueSeparator);

        final key = tagMap[0];
        if (key == _tmdbId) {
          continue;
        }
        final value = tagMap[1];

        tagData.putIfAbsent(key, () => <String>{}).add(value);
      }
    }

    return tagData;
  }
}
