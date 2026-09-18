import '../data/entities/validation_result.dart';

abstract class TagsValidator {
  TagsValidator? _next;

  TagsValidator setNext(TagsValidator next) {
    _next = next;
    return next;
  }

  TagsValidationResult validate(String? tags) {
    final result = check(tags);
    if (result != null) {
      return result;
    }
    if (_next != null) {
      return _next!.validate(tags);
    }
    return TagsValidationResult.validTagsField;
  }

  TagsValidationResult? check(String? tags);
}

class EmptyTagsValidator extends TagsValidator {
  @override
  TagsValidationResult? check(String? tags) {
    if (tags == null || tags.isEmpty) {
      return TagsValidationResult.emptyTags;
    }
    return null;
  }
}

class FormatTagsValidator extends TagsValidator {
  final String _tagSplit = ",";
  final String _valueSplit = ":";

  @override
  TagsValidationResult? check(String? tags) {
    if (!tags!.contains(_tagSplit)) {
      return TagsValidationResult.invalidFormatTagsFormat;
    }
    if (!tags.contains(_valueSplit)) {
      return TagsValidationResult.invalidFormatTagsFormat;
    }

    var tagData = tags
        .split(_tagSplit)
        .map((tag) => tag.trim().split(_valueSplit))
        .toList();
    if (!tagData.every(
      (tag) => tag.length == 2 && tag[0].isNotEmpty && tag[1].isNotEmpty,
    )) {
      return TagsValidationResult.invalidFormatTagsFormat;
    }

    return null;
  }
}

class UniqueSourceTagValidator extends TagsValidator {
  @override
  TagsValidationResult? check(String? tags) {
    var tagData = tags!.split(",").map((tag) => tag.trim().split(":")).toList();
    var sourceTags = tagData.where((tag) => tag[0] == "source").toList();
    if (sourceTags.length > 1) {
      return TagsValidationResult.nonUniqueSourceTag;
    }
    return null;
  }
}

class UniqueTmdbIdTagValidator extends TagsValidator {
  @override
  TagsValidationResult? check(String? tags) {
    var tagData = tags!.split(",").map((tag) => tag.trim().split(":")).toList();
    var tmdbIdTags = tagData.where((tag) => tag[0] == "tmdb_id").toList();
    if (tmdbIdTags.length > 1) {
      return TagsValidationResult.nonUniqueTmdbIdTag;
    }
    return null;
  }
}

class ContainsGenreTagValidator extends TagsValidator {
  @override
  TagsValidationResult? check(String? tags) {
    var tagData = tags!.split(",").map((tag) => tag.trim().split(":")).toList();
    var genreTags = tagData.where((tag) => tag[0] == "genre").toList();
    if (genreTags.isEmpty) {
      return TagsValidationResult.missingGenreTag;
    }
    return null;
  }
}

class TagValidationService {
  late final TagsValidator _validationChain;

  TagValidationService() {
    final empty = EmptyTagsValidator();
    final format = FormatTagsValidator();
    final uniqueSource = UniqueSourceTagValidator();
    final uniqueTmdbId = UniqueTmdbIdTagValidator();
    final genre = ContainsGenreTagValidator();

    empty.setNext(format);
    format.setNext(uniqueSource);
    uniqueSource.setNext(uniqueTmdbId);
    uniqueTmdbId.setNext(genre);

    _validationChain = empty;
  }

  TagsValidationResult checkMovieTags(String? tags) {
    return _validationChain.validate(tags);
  }
}
