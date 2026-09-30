import 'package:media_watch/data/entities/validation_result.dart';
import 'package:media_watch/services/tag_validation_service.dart';
import 'package:test/test.dart';

void main() {
  group('Tags Validator Tests', () {
    group('Single Tags Validator', () {
      test('Must result in Empty Tags Validation - null String', () {
        // GIVEN
        TagsValidator tagsValidator = EmptyTagsValidator();

        String? tags;

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.emptyTags);
      });

      test('Must result in Empty Tags Validation - empty String', () {
        // GIVEN
        TagsValidator tagsValidator = EmptyTagsValidator();

        String? tags = '';

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.emptyTags);
      });

      test('Must result in FormatTags Validation - single value', () {
        // GIVEN
        TagsValidator tagsValidator = FormatTagsValidator();

        String? tags = "value";

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.invalidTagsFormat);
      });

      test(
        'Must result in FormatTags Validation - value separated by commas',
            () {
          // GIVEN
          TagsValidator tagsValidator = FormatTagsValidator();

          String? tags = "value, value";

          // WHEN
          TagValidationResult result = tagsValidator.validate(tags);

          // THEN
          expect(result, TagValidationResult.invalidTagsFormat);
        },
      );

      test('Must result in FormatTags Validation - key with : but no value', () {
        // GIVEN
        TagsValidator tagsValidator = FormatTagsValidator();

        String? tags = "key1:value,key2:";

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.invalidTagsFormat);
      });

      test('Must result in FormatTags Validation - mixed values', () {
        // GIVEN
        TagsValidator tagsValidator = FormatTagsValidator();

        String? tags = "key:value,";

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.invalidTagsFormat);
      });

      test('No source tag', () {
        // GIVEN
        TagsValidator tagsValidator = MissingSourceTagValidator();

        String? tags = "key:value";

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.missingSourceTag);
      });

      test('Multiple sources tags', () {
        // GIVEN
        TagsValidator tagsValidator = UniqueSourceTagValidator();

        String? tags = "source:source1, source:source2";

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.nonUniqueSourceTag);
      });

      test('No tmdb_id tag', () {
        // GIVEN
        TagsValidator tagsValidator = MissingTmdbIdTagValidator();

        String? tags = "key:value";

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.missingTMDBIDTag);
      });

      test('Multiple tmdb_id tags', () {
        // GIVEN
        TagsValidator tagsValidator = UniqueTmdbIdTagValidator();

        String? tags = "tmdb_id:12345, tmdb_id:67890";

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.nonUniqueTmdbIdTag);
      });

      test('Missing genre tag', () {
        // GIVEN
        TagsValidator tagsValidator = ContainsGenreTagValidator();

        String? tags = "source:12345, tmdb_id:67890";

        // WHEN
        TagValidationResult result = tagsValidator.validate(tags);

        // THEN
        expect(result, TagValidationResult.missingGenreTag);
      });
    });

    group("Chain Testing", () {
      TagValidationService validationService = TagValidationService();

      test('Must result in Empty Tags Validation - null String', () {
        // GIVEN
        String? tags;

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.emptyTags);
      });

      test('Must result in Empty Tags Validation - empty String', () {
        // GIVEN
        String? tags = '';

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.emptyTags);
      });

      test('Must result in FormatTags Validation - single value', () {
        // GIVEN
        String? tags = "value";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.invalidTagsFormat);
      });

      test(
        'Must result in FormatTags Validation - value separated by commas',
            () {
          // GIVEN
          String? tags = "value, value";

          // WHEN
          TagValidationResult result = validationService.checkMovieTags(tags);
          // THEN
          expect(result, TagValidationResult.invalidTagsFormat);
        },
      );

      test('Must result in FormatTags Validation - key with : but no value', () {
        // GIVEN
        String? tags = "key1:value,key2:";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.invalidTagsFormat);
      });

      test('Must result in FormatTags Validation - mixed values', () {
        // GIVEN
        String? tags = "key:value,";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.invalidTagsFormat);
      });

      test('No source tag', () {
        // GIVEN
        String? tags = "genre:action, tmdb_id:12255";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.missingSourceTag);
      });

      test('Multiple sources tags', () {
        // GIVEN
        String? tags = "source:source1, source:source2";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.nonUniqueSourceTag);
      });

      test('No tmdb_id tag', () {
        // GIVEN
        String? tags = "source:any, genre:action";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.missingTMDBIDTag);
      });

      test('Multiple tmdb_id tags', () {
        // GIVEN
        String? tags = "source:mySource, tmdb_id:12345, tmdb_id:67890";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.nonUniqueTmdbIdTag);
      });

      test('Missing genre tag', () {
        // GIVEN
        String? tags = "source:12345, tmdb_id:67890";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.missingGenreTag);
      });

      test('Everything is alright', () {
        // GIVEN
        String? tags =
            "source:12345, genre:some, genre:other, tmdb_id:67890, adaption:external, style:full";

        // WHEN
        TagValidationResult result = validationService.checkMovieTags(tags);

        // THEN
        expect(result, TagValidationResult.validTagsField);
      });
    });
  });
}
