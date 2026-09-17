import 'package:media_watch/data/entities/validation_result.dart';
import 'package:media_watch/services/tag_validation_service.dart';
import 'package:test/test.dart';


void main() {
  group('Single Tags Validator', () {
    test('Must result in Empty Tags Validation - null String', () {
      // GIVEN
      TagValidationService service = TagValidationService();

      String? tags;

      // WHEN
      TagsValidationResult result = service.checkMovieTags(tags);

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
}