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
    var myTags = tags!.trim();
    if (!myTags.contains(_tagSplit)) {
      return TagsValidationResult.invalidTagsFormat;
    }
    if (!myTags.contains(_valueSplit)) {
      return TagsValidationResult.invalidTagsFormat;
    }

    var tagData = myTags
        .split(_tagSplit)
        .map((tag) => tag.trim().split(_valueSplit))
        .toList();
    if (!tagData.every(
      (tag) => tag.length == 2 && tag[0].isNotEmpty && tag[1].isNotEmpty,
    )) {
      return TagsValidationResult.invalidTagsFormat;
    }

    return null;
  }
}

// New check ....: SourceTagValidator
// Predecessor ..: FormatTagsValidator
// Successor ....: UniqueSourceTagValidator
// Checks if source tag exists
// Returns TagsValidationResult.noSourceTag

class UniqueSourceTagValidator extends TagsValidator {
  final String _tagName = "source";
  @override
  TagsValidationResult? check(String? tags) {
    if (!tags!.contains(_tagName)) {
      return TagsValidationResult.nonUniqueSourceTag;
    }
    var tagData = tags.split(",").map((tag) => tag.trim().split(":")).toList();
    var sourceTags = tagData.where((tag) => tag[0] == _tagName).toList();
    if (sourceTags.length > 1) {
      return TagsValidationResult.nonUniqueSourceTag;
    }
    return null;
  }
}

// New check ....: TmdbIdTagValidator
// Predecessor ..: UniqueSourceTagValidator
// Successor ....: UniqueTmdbIdTagValidator
// Checks if tmdb_id tag exists
// Returns TagsValidationResult.noTmdbIdTag

class UniqueTmdbIdTagValidator extends TagsValidator {
  final String _tagName = "tmdb_id";

  @override
  TagsValidationResult? check(String? tags) {
    if (!tags!.contains(_tagName)) {
      return TagsValidationResult.nonUniqueSourceTag;
    }
    var tagData = tags.split(",").map((tag) => tag.trim().split(":")).toList();
    var tmdbIdTags = tagData.where((tag) => tag[0] == _tagName).toList();
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
    final emptyValidator = EmptyTagsValidator();
    final formatValidator = FormatTagsValidator();
    final uniqueSourceValidator = UniqueSourceTagValidator();
    final uniqueTmdbIdValidator = UniqueTmdbIdTagValidator();
    final genreValidator = ContainsGenreTagValidator();

    emptyValidator.setNext(formatValidator);
    formatValidator.setNext(uniqueSourceValidator);
    uniqueSourceValidator.setNext(uniqueTmdbIdValidator);
    uniqueTmdbIdValidator.setNext(genreValidator);

    _validationChain = emptyValidator;
  }

  TagsValidationResult checkMovieTags(String? tags) {
    return _validationChain.validate(tags);
  }
}
