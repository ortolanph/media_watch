import 'package:media_watch/data/entities/validation_result.dart';
import 'package:media_watch/services/tag_validation_service.dart';
import 'package:test/test.dart';


void main() {
  group('Single Tags Validator', () {
    test('Must result in Empty Tags Validation - null String', () {
      // GIVEN
      TagsValidator tagsValidator = EmptyTagsValidator();

      String? tags;

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.emptyTags);
    });

    test('Must result in Empty Tags Validation - empty String', () {
      // GIVEN
      TagsValidator tagsValidator = EmptyTagsValidator();

      String? tags = '';

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.emptyTags);
    });

    test('Must result in FormatTags Validation - single value', () {
      // GIVEN
      TagsValidator tagsValidator = FormatTagsValidator();

      String? tags = "value";

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.invalidFormatTagsFormat);
    });

    test('Must result in FormatTags Validation - value separated by commas', () {
      // GIVEN
      TagsValidator tagsValidator = FormatTagsValidator();

      String? tags = "value, value";

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.invalidFormatTagsFormat);
    });

    test('Must result in FormatTags Validation - key with : but no value', () {
      // GIVEN
      TagsValidator tagsValidator = FormatTagsValidator();

      String? tags = "key1:value,key2:";

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.invalidFormatTagsFormat);
    });

    test('Must result in FormatTags Validation - mixed values', () {
      // GIVEN
      TagsValidator tagsValidator = FormatTagsValidator();

      String? tags = "key:value,";

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.invalidFormatTagsFormat);
    });

    test('Multiple sources tags', () {
      // GIVEN
      TagsValidator tagsValidator = UniqueSourceTagValidator();

      String? tags = "source:source1, source:source2";

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.nonUniqueSourceTag);
    });

    test('Multiple tmdb_id tags', () {
      // GIVEN
      TagsValidator tagsValidator = UniqueTmdbIdTagValidator();

      String? tags = "tmdb_id:12345, tmdb_id:67890";

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.nonUniqueTmdbIdTag);
    });

    test('Missing genre tag', () {
      // GIVEN
      TagsValidator tagsValidator = ContainsGenreTagValidator();

      String? tags = "source:12345, tmdb_id:67890";

      // WHEN
      TagsValidationResult result = tagsValidator.validate(tags);

      // THEN
      expect(result, TagsValidationResult.missingGenreTag);
    });
  });

  group("Chain Testing", () {
    TagValidationService validationService = TagValidationService();

    test('Must result in Empty Tags Validation - null String', () {
      // GIVEN
      String? tags;

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.emptyTags);
    });

    test('Must result in Empty Tags Validation - empty String', () {
      // GIVEN
      String? tags = '';

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.emptyTags);
    });

    test('Must result in FormatTags Validation - single value', () {
      // GIVEN
      String? tags = "value";

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.invalidFormatTagsFormat);
    });

    test('Must result in FormatTags Validation - value separated by commas', () {
      // GIVEN
      String? tags = "value, value";

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);
      // THEN
      expect(result, TagsValidationResult.invalidFormatTagsFormat);
    });

    test('Must result in FormatTags Validation - key with : but no value', () {
      // GIVEN
      String? tags = "key1:value,key2:";

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.invalidFormatTagsFormat);
    });

    test('Must result in FormatTags Validation - mixed values', () {
      // GIVEN
      String? tags = "key:value,";

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.invalidFormatTagsFormat);
    });

    test('Multiple sources tags', () {
      // GIVEN
      String? tags = "source:source1, source:source2";

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.nonUniqueSourceTag);
    });

    test('Multiple tmdb_id tags', () {
      // GIVEN
      String? tags = "tmdb_id:12345, tmdb_id:67890";

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.nonUniqueTmdbIdTag);
    });

    test('Missing genre tag', () {
      // GIVEN
      String? tags = "source:12345, tmdb_id:67890";

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.missingGenreTag);
    });

    test('Everything is alright', () {
      // GIVEN
      String? tags = "source:12345, genre:some, genre:other, tmdb_id:67890, adaption:external, style:full";

      // WHEN
      TagsValidationResult result = validationService.checkMovieTags(tags);

      // THEN
      expect(result, TagsValidationResult.validTagsField);
    });
  });
}