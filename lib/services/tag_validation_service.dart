import '../data/entities/validation_result.dart';

abstract class TagsValidator {
  TagsValidator? _next;

  TagsValidator setNext(TagsValidator next) {
    _next = next;
    return next;
  }

  TagValidationResult validate(String? tags) {
    final result = check(tags);
    if (result != null) {
      return result;
    }
    if (_next != null) {
      return _next!.validate(tags);
    }
    return TagValidationResult.validTagsField;
  }

  TagValidationResult? check(String? tags);
}

class EmptyTagsValidator extends TagsValidator {
  @override
  TagValidationResult? check(String? tags) {
    if (tags == null || tags.isEmpty) {
      return TagValidationResult.emptyTags;
    }
    return null;
  }
}

class FormatTagsValidator extends TagsValidator {
  final String _tagSplit = ",";
  final String _valueSplit = ":";

  @override
  TagValidationResult? check(String? tags) {
    var myTags = tags!.trim();
    if (!myTags.contains(_tagSplit)) {
      return TagValidationResult.invalidTagsFormat;
    }
    if (!myTags.contains(_valueSplit)) {
      return TagValidationResult.invalidTagsFormat;
    }

    var tagData = myTags
        .split(_tagSplit)
        .map((tag) => tag.trim().split(_valueSplit))
        .toList();
    if (!tagData.every(
      (tag) => tag.length == 2 && tag[0].isNotEmpty && tag[1].isNotEmpty,
    )) {
      return TagValidationResult.invalidTagsFormat;
    }

    return null;
  }
}

class MissingSourceTagValidator extends TagsValidator {
  final String _tagName = "source:";

  @override
  TagValidationResult? check(String? tags) {
    if (!tags!.contains(_tagName)) {
      return TagValidationResult.missingSourceTag;
    }

    return null;
  }
}

class UniqueSourceTagValidator extends TagsValidator {
  final String _tagName = "source";

  @override
  TagValidationResult? check(String? tags) {
    var tagData = tags!.split(",").map((tag) => tag.trim().split(":")).toList();
    var sourceTags = tagData.where((tag) => tag[0] == _tagName).toList();
    if (sourceTags.length > 1) {
      return TagValidationResult.nonUniqueSourceTag;
    }
    return null;
  }
}

class MissingTmdbIdTagValidator extends TagsValidator {
  final String _tagName = "tmdb_id:";

  @override
  TagValidationResult? check(String? tags) {
    if (!tags!.contains(_tagName)) {
      return TagValidationResult.missingTMDBIDTag;
    }

    return null;
  }
}

class UniqueTmdbIdTagValidator extends TagsValidator {
  final String _tagName = "tmdb_id";

  @override
  TagValidationResult? check(String? tags) {
    if (!tags!.contains(_tagName)) {
      return TagValidationResult.nonUniqueSourceTag;
    }
    var tagData = tags.split(",").map((tag) => tag.trim().split(":")).toList();
    var tmdbIdTags = tagData.where((tag) => tag[0] == _tagName).toList();
    if (tmdbIdTags.length > 1) {
      return TagValidationResult.nonUniqueTmdbIdTag;
    }
    return null;
  }
}

class ContainsGenreTagValidator extends TagsValidator {
  @override
  TagValidationResult? check(String? tags) {
    var tagData = tags!.split(",").map((tag) => tag.trim().split(":")).toList();
    var genreTags = tagData.where((tag) => tag[0] == "genre").toList();
    if (genreTags.isEmpty) {
      return TagValidationResult.missingGenreTag;
    }
    return null;
  }
}

class TagValidationService {
  late final TagsValidator _validationChain;

  TagValidationService() {
    final emptyValidator = EmptyTagsValidator();
    final formatValidator = FormatTagsValidator();
    final missingSourceValidator = MissingSourceTagValidator();
    final uniqueSourceValidator = UniqueSourceTagValidator();
    final missingTmdbIdValidator = MissingTmdbIdTagValidator();
    final uniqueTmdbIdValidator = UniqueTmdbIdTagValidator();
    final genreValidator = ContainsGenreTagValidator();

    emptyValidator.setNext(formatValidator);
    formatValidator.setNext(missingSourceValidator);
    missingSourceValidator.setNext(uniqueSourceValidator);
    uniqueSourceValidator.setNext(missingTmdbIdValidator);
    missingTmdbIdValidator.setNext(uniqueTmdbIdValidator);
    uniqueTmdbIdValidator.setNext(genreValidator);

    _validationChain = emptyValidator;
  }

  TagValidationResult checkMovieTags(String? tags) {
    return _validationChain.validate(tags);
  }
}
